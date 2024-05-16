import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orders/components/components.dart';
import 'package:orders/model/HaveOrderModel.dart';
import 'package:orders/model/TaxiModel.dart';
import 'package:orders/user-layout/cubit/states.dart';
import 'package:orders/user-layout/moduels/orderScreens/OrderScreen.dart';
import '../../model/ItemModel.dart';
import '../../model/ItemPharmaModel.dart';
import '../../model/ItemSalaModel.dart';
import '../../model/OrderModel.dart';
import '../../model/ShopModel.dart';
import '../../model/UserModel.dart';
import '../../shared/local/cache_helper.dart';
import '../moduels/profileScreens/profile.dart';
import '../moduels/servicesScreens/ServiceScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  void inc(int i){

    counters![i]++;
      emit(IncSuccessState());
  }
  void dec(int i){

    if(counters![i]>=1){counters![i]--;
   emit(DecSuccessState());}
  }
  List<int>? counters;
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex==0){

    }
    if (currentIndex==1){
      if(ud!=''){
      userdata!=null?getMyOrder(city: userdata!.city, customerId: userdata!.uId!):null;
      }else{
        showToast(text: 'سجل دخول اولا', state: ToastStates.warning);
        currentIndex==2;
      }
    }
    if (currentIndex==2){
      if(ud!='' && ud!=null){
        getUser(ud);
      }
    }
    emit(AppChangeBottomNavBarState());
  }
  List<Widget> screens = [
     const ServicesScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];
  List<String> titles = [
    'الرئيسية',
    'طلبي',
    'الملف الشخصي',
  ];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.auto_awesome_mosaic_outlined,),
        label: 'الرئيسية'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag,),
        label: 'طلبي'),
    const BottomNavigationBarItem(
        icon:   Icon(Icons.person,),
        label: 'الملف الشخصي'),

  ];
  void signOut(){
    emit(LogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      emit(LogoutSuccessState());
    });
  }
  UserModel? userdata;
  List<UserModel> allUsers=[];

  void getUsers() {
    allUsers.clear();

    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        allUsers.add(UserModel.fromjson(element.data()));}
      emit(GetUsersSuccessStates());
    });
  }
  void getUser(uid) {
    emit(GetUserLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uid.toString()).get().then((value) {
      userdata = UserModel.fromjson(value.data()!);
      emit(GetUserSuccessStates());
    });
  }
  void updateProfile({
    required String image,
    required String name,
    required String phone,
    required String email,}) {
    UserModel model = UserModel(
        image: image,
        name: name,
        uId: ud,
        phone: phone,
        email: email,
        Longitude: '',
        Latitude: '', city: ''
    );
    emit(ImageIntStates());
    FirebaseFirestore.instance.collection('users').doc(ud).update(model.Tomap()).then((value) {
      emit(UpdateProductSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }
  String imageUrl2 = '';
  String address='';
  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ImageIntStates());
    FirebaseStorage.instance.ref().child('users/${Uri
        .file(pickedFile2!.path)
        .pathSegments
        .last}').putFile(pickedFile2!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl2 = value;
        createUser(
            image: imageUrl2,
            name: name,
            email: email,
            phone: phone,
            uId: ud);
        pickedFile2 = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createUser({
    required String image,
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {
    UserModel model=UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        image: image,
        Longitude: '', Latitude: '', city: ''

    );

    FirebaseFirestore.instance.collection("users").doc(uId).set(model.Tomap()).then((value) {

      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }
//////////////////////FoodShops//////////////////
  List<ShopModel> foodShops=[];
  void getFoodShops(String type){
    foodShops.clear();
    FirebaseFirestore.instance.collection("food").doc(type).collection(type).get().then((value) {
      for (var element in value.docs) {
        foodShops.add(ShopModel.fromjson(element.data()));
      }
      emit(GetFoodShopsSuccessState(type));

    });
  }
  ////////////////////////markets////////////
  List<ShopModel> marketShops=[];
  void getMarketShops(String type){
    marketShops.clear();
    FirebaseFirestore.instance.collection("market").doc(type).collection(type).get().then((value) {

      for (var element in value.docs) {
        marketShops.add(ShopModel.fromjson(element.data()));
      }
      emit(GetFoodShopsSuccessState(type));

    });
  }
  List<ItemModel> foodMenu=[];
  void getFoodMenu(String type,String restaurant,String id,   String shopLatitude,
  String shopLongitude){
    foodMenu.clear();
    FirebaseFirestore.instance.collection("food").doc(type).collection(type).doc(id).collection('menu').get().then((value) {
      for (var element in value.docs) {
        foodMenu.add(ItemModel.fromjson(element.data()));
      }
      emit(GetUserFoodMenuSuccessState(type,restaurant,shopLatitude,shopLongitude));

    });
  }
  List<ItemModel> marketMenu=[];
  void getMarketMenu(String type,String market,String id){
    marketMenu.clear();
    FirebaseFirestore.instance.collection("market").doc(type).collection(type).doc(id).collection('menu').get().then((value) {
      for (var element in value.docs) {
        marketMenu.add(ItemModel.fromjson(element.data()));
      }
      emit(GetUserMarketMenuSuccessState(type,market));

    });
  }
  /////////////////Sala/////////////////////
    List<ItemSalaModel> sala=[];
  List<ItemSalaModel> toolsSala=[];
  List<ItemPharmaModel> pharmaSala=[];
    void addToSala(){

    for (int i=0; i<counters!.length; i++ ) {
    if(counters![i] != 0){

    sala.add(
    ItemSalaModel(
    name: foodMenu[i].name ,
    amount: counters![i] ,
    publisherId: foodMenu[i].publisherId ,
    price: foodMenu[i].price ,
    image: foodMenu[i].image ));
      }}
    emit(AddToSalaSuccessStates());
    }

  void addToPharmaSala(
      String name,
      String hint,
      String pharmaName,
      String address,
      ){
    emit(ImageIntStates());
    FirebaseStorage.instance.ref().child('users/${Uri
        .file(pickedFiles!.path)
        .pathSegments
        .last}').putFile(pickedFiles!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl2 = value;

        pickedFiles = null;
        pharmaSala.add(
            ItemPharmaModel(
              name: name,
              hint: hint,
              address: address,
              pharmaName: pharmaName, image: imageUrl2,));
        emit(ImageSuccessStates())
        ;
      });

    });



  }
  File? pickedFiles;
  Future<void> getItemImage() async {
    final imageFile = await picker2.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      pickedFiles=File(imageFile.path);
      emit(SelectImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(SelectProductImageErrorStates(error.toString()));
    }
  }
  void setPharmaOrder({
    required String totalPrice,
    required String date,
    required String customerId,
    required String shopName,
    required String city,
    required String state,
    required String latitude,
    required String longitude,
    required String shopLatitude,
    required String shopLongitude,
  }){
    emit(OrderLoadingState());
    order=OrderModel(
        totalPrice: totalPrice,
        date: date,
        customerId: customerId,
        city: city,
        state: state,
        Latitude: latitude,
        Longitude: longitude,
        shopName:shopName,
        shopLatitude: shopLatitude,
        shopLongitude: shopLongitude, type: 'order' );
    FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).
    doc(date).set(order!.Tomap()).then((value) async {
      await setOrderPharmaItems(city: city, customerId: customerId, date: date);
      emit(OrderSuccessState());
    });
  }
  Future<void> setOrderPharmaItems({
    required String city,
    required String customerId,
    required String date,
  })async{
    for (var element in pharmaSala) {
      var orderItem=ItemPharmaModel(hint: element.hint, name: element.name,
          address: element.address, pharmaName: element.pharmaName, image: element.image);
      FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).
      doc(date).collection('order').add(orderItem.Tomap());}

  }
  void addToolsSala(){

    for (int i=0; i<counters!.length; i++ ) {
      if(counters![i] != 0){

        toolsSala.add(
            ItemSalaModel(
                name: items[i].name ,
                amount: counters![i] ,
                publisherId: items[i].publisherId ,
                price: items[i].price ,
                image: items[i].image ));
      }}
    emit(AddToolSalaSuccessStates());
  }

  ////////////////////////////////////////
  var items=[ItemModel(
      name: 'شوكه',
      publisherId: '',
      desc: 'شوكه معدن استانلس',
      price: '13',
      image: "https://m.media-amazon.com/images/I/41uwyZDv5SL.__AC_SX300_SY300_QL70_ML2_.jpg"
  ),ItemModel(
      name: 'سكينه',
      publisherId: '',
      desc: 'سكينة 6 بوصه',
      price: '13',
      image: "https://tulipe.com/media/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/8/8/8809533003500_1.jpg"
  ),
    ItemModel(
        name: 'طبق',
        publisherId: '',
        desc: ' سرفيس صغير بيضاوي ',
        price: '13',
        image: "https://alshroukmel.com/wp-content/uploads/2020/08/s2_0001_Vector-Smart-Object-copy-12.jpg"
    ),
    ItemModel(
        name: 'سبت غسيل',
        publisherId: '',
        desc: 'سبت  100*60',
        price: '13',
        image: "https://byootmisr.com/wp-content/uploads/2023/03/701097.png"
    ),
  ];
    ///////////////////setOrder/////////////////

  OrderModel? order;
    void setOrder({
      required String totalPrice,
      required String date,
      required String customerId,
      required String shopName,
      required String city,
      required String state,
      required String latitude,
      required String longitude,
      required String shopLatitude,
      required String shopLongitude,
      required List<ItemSalaModel> sala,
    }){
      emit(OrderLoadingState());
      order=OrderModel(
          totalPrice: totalPrice,
          date: date, 
          customerId: customerId,
          city: city, 
          state: state, 
          Latitude: latitude, 
          Longitude: longitude,
          shopName:shopName,
          shopLatitude: shopLatitude,
          shopLongitude: shopLongitude, type: 'order' );
      FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).
      doc(date).set(order!.Tomap()).then((value) async {
         await setOrderItems(city: city, customerId: customerId, date: date, sala: sala);
         emit(OrderSuccessState());
      });
    }
  void setHaveOrder({

    required String date,
    required String customerId,
    required String price,
    required String city,
    required String state,
    required String latitude,
    required String longitude,
    required String cLatitude,
    required String cLongitude,
    required String shopName,
    required HaveOrderModel orderModel,
  }){
    emit(HaveOrderLoadingState());
    order=OrderModel(
        totalPrice: price,
        date: date,
        customerId: customerId,
        city: city,
        state: state,
        Latitude: latitude,
        Longitude: longitude,
        shopName:shopName,
        shopLatitude: cLatitude,
        shopLongitude: cLongitude, type: 'delivery' );
    FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).
    doc(date).set(order!.Tomap()).then((value) async {
      await setHaveOrderItems(city: city, customerId: customerId, date: date, orderItem: orderModel);
      emit(HaveOrderSuccessState());
    });
  }
  Future<void> setHaveOrderItems({
    required String city,
    required String customerId,
    required String date,
    required HaveOrderModel orderItem,

  })async{

    FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).
    doc(date).collection('order').add(orderItem.toMap());

  }
  Future<void> setOrderItems({
    required String city,
    required String customerId,
    required String date,
    required List<ItemSalaModel> sala,

  })async{
      for (var element in sala) {
   var orderItem=ItemSalaModel(name: element.name, amount: element.amount,
       publisherId: element.publisherId, price: element.price, image: element.image);
    FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).
    doc(date).collection('order').add(orderItem.Tomap());}

  }
  List<OrderModel> myOrders=[];
  Future<void> getMyOrder({
    required String city,
    required String customerId,
  })async{
    emit(GetMyOrderLoadingState());
    myOrders.clear();
      FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).orderBy('date',descending: true)
       .get().then((value) {
        value.docs.forEach((element) {
        myOrders.add(OrderModel.fromjson(element.data()));
        });
        emit(GetMyOrderSuccessState());
      });}
  List<ItemSalaModel> myOrdersItems=[];
  Future<void> getMyOrderItems({
    required String city,
    required String customerId,
    required String date,

  })async{
    emit(GetMyOrderItemLoadingState());
    myOrdersItems.clear();
    FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).doc(date).collection('order')
        .get().then((value) {
      value.docs.forEach((element) {
        myOrdersItems.add(ItemSalaModel.fromjson(element.data()));
      });
      emit(GetMyOrderItemSuccessState());
    });}
  List<HaveOrderModel> myOrdersItems2=[];
  Future<void> getMyOrderItems2({
    required String city,
    required String customerId,
    required String date,

  })async{
    emit(GetMyOrderItemLoadingState());
    myOrdersItems2.clear();
    FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).doc(date).collection('order')
        .get().then((value) {
      value.docs.forEach((element) {
        myOrdersItems2.add(HaveOrderModel.fromJson(element.data()));
      });
      emit(GetMyOrderItemSuccessState());
    });}
  List<TaxiModel> myTaxiOrders=[];
  Future<void> getMyTaxiOrder({
    required String city,
    required String customerId,
    required String date,

  })async{
    emit(GetMyOrderItemLoadingState());
    myTaxiOrders.clear();
    FirebaseFirestore.instance.collection("orders").doc(city).collection(customerId).doc(date).collection('order')
        .get().then((value) {
      for (var element in value.docs) {
        myTaxiOrders.add(TaxiModel.fromjson(element.data()));
      }
      emit(GetMyOrderItemSuccessState());
    });}
  OrderModel? taxiOrder;
  void setTaxiOrder({
    required String totalPrice,
    required String shopName,
    required String city,
    required String state,
    required String latitude,
    required String longitude,
    required String shopLatitude,
    required String shopLongitude,
    required TaxiModel sala,
  }){
    var date= DateTime.now().toString();
    emit(OrderLoadingState());
    taxiOrder=OrderModel(
        totalPrice: totalPrice,
        date: date,
        customerId: ud,
        city: city,
        state: state,
        Latitude: latitude,
        Longitude: longitude,
        shopName:"taxi",
        shopLatitude: shopLatitude,
        shopLongitude: shopLongitude, type: 'taxi' );
    FirebaseFirestore.instance.collection("orders").doc(city).collection(ud).
    doc(date).set(taxiOrder!.Tomap()).then((value) async {
      await  FirebaseFirestore.instance.collection("orders").doc(city).collection(ud).
      doc(date).collection('order').add(sala.Tomap());
      emit(OrderSuccessState());
    });
  }

/////////////////////////image///////////
  final ImagePicker picker2 = ImagePicker();
  File? pickedFile2;
  Future<void> getImage2() async {
    final imageFile = await picker2.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      pickedFile2 = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  final ImagePicker picker = ImagePicker();
  File? pickedFile;
  Future<void> getImage() async {
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      pickedFile = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  ////////////////////upload workshop/////////////
  String ud =  CacheHelper.getData(key: 'uId');

  String latitude = '';
  String longitude = '';
  Set<Marker> markers = {};

  Future<void> getLocation() async {

    if (await Permission.location.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
      latitude = position.latitude.toString();
      longitude= position.longitude.toString();
      emit(GetLocationSuccessState());

    } else {
      // Request location permissions
      PermissionStatus permissionStatus = await Permission.location.request();

      if (permissionStatus.isGranted) {
        // Permission granted, retrieve location
        await getLocation();
      } else {
        // Permission denied
      latitude = '';

      }
    }
  }
  void selectLocation(LatLng latLng){
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,

    ));
   double dis= Geolocator.distanceBetween(
       double.parse(latitude), double.parse(longitude),
       latLng.latitude, latLng.longitude);
    emit(SelectLocation(dis));
  }
}