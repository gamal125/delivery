import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orders/model/ItemModel.dart';
import 'package:orders/model/ShopModel.dart';
import '../../model/UserModel.dart';
import '../../shared/local/cache_helper.dart';
import '../moduels/ShopProfileScreens/profile.dart';
import '../moduels/ShopServicesScreens/ShopServiceScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ShopStates.dart';




class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());
  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex==0){

    }
    if (currentIndex==1){}
    if (currentIndex==2){
      if(ud!='' && ud!=null){
        getUser(ud);
      }
    }
    emit(ShopAppChangeBottomNavBarState());
  }
  List<Widget> screens = [
     const ShopServicesScreen(),
    const ShopProfileScreen(),
    const ShopProfileScreen(),
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
  /////////////user/////////////////////
  void signOut(){
    emit(ShopLogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      emit(ShopLogoutSuccessState());
    });
  }
  UserModel? userdata;
  List<UserModel> allUsers=[];
  String imageUrl2 = '';
  String address='';
  void getUsers() {
    allUsers.clear();

    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        allUsers.add(UserModel.fromjson(element.data()));}
      emit(ShopGetUsersSuccessStates());
    });
  }
  void getUser(uid) {
    emit(ShopGetUserLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uid.toString()).get().then((value) {
      userdata = UserModel.fromjson(value.data()!);
      emit(ShopGetUserSuccessStates());
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
    emit(ShopImageIntStates());
    FirebaseFirestore.instance.collection('users').doc(ud).update(model.Tomap()).then((value) {
      emit(ShopUpdateProductSuccessStates());
    }).catchError((error) {
      emit(ShopUpdateProductErrorStates(error.toString()));
    });
  }
  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopImageIntStates());
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

        emit(ShopImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ShopImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ShopImageErrorStates(error));
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

      emit(ShopCreateUserSuccessState());
    }).catchError((error) {
      emit(ShopCreateUserErrorState(error.toString()));
    });
  }

/////////////////////////image///////////
  final ImagePicker picker2 = ImagePicker();
  File? pickedFile2;
  Future<void> getImage2() async {
    final imageFile = await picker2.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      pickedFile2 = File(imageFile.path);
      emit(ShopUpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(ShopUpdateProductImageErrorStates(error.toString()));
    }
  }
  final ImagePicker picker = ImagePicker();
  File? pickedFile;
  Future<void> getImage() async {
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      pickedFile = File(imageFile.path);
      emit(ShopUpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(ShopUpdateProductImageErrorStates(error.toString()));
    }
  }
  ///////////////////////food///////////////////
  void uploadFoodImage({
    required String name,
    required String category,
    required String type,
  }) {
    emit(ShopImageIntStates());
    FirebaseStorage.instance.ref().child('shops/${Uri
        .file(pickedFile2!.path)
        .pathSegments
        .last}').putFile(pickedFile2!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl2 = value;
       createFood(
          type: type,
          image: imageUrl2,
          name: name, category:category,
        ) ;
        pickedFile2 = null;

        emit(ShopImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ShopImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ShopImageErrorStates(error));
    });
  }

  void createFood({
    required String image,
    required String name,
    required String category,
    required String type
  }) {
    ShopModel model=ShopModel(
        name: name,
        uId: ud,
        image: image,
        Longitude: longitude,
        Latitude:latitude, rate: '', city: userdata!.city);
    FirebaseFirestore.instance.collection(category).doc(type).collection(type).doc(ud).set(model.Tomap()).then((value) {
      emit(ShopCreateFoodSuccessState());
    }).catchError((error) {
      emit(ShopCreateShopErrorState(error.toString()));});}

  ShopModel? mYFoodShop;
  void getMYFoodShop(String type){
    FirebaseFirestore.instance.collection("food").doc(type).collection(type).doc(ud).get().then((value) {
      value.data()!=null? mYFoodShop=ShopModel.fromjson(value.data()!):mYFoodShop=null;
      emit(GetMYFoodShopSuccessState(type));

    });
  }
  ShopModel? mYMarketShop;
  void getMYMarketShop(String type){
    FirebaseFirestore.instance.collection("market").doc(type).collection(type).doc(ud).get().then((value) {
      value.data()!=null? mYMarketShop=ShopModel.fromjson(value.data()!):mYMarketShop=null;
      emit(GetMYMarketShopSuccessState(type));

    });
  }
/////////////////////menu///////////
  void uploadMenuImage({
    required String restaurant,
    required String foodType,
    required String name,
    required String category,
    required String price,
    required String desc,
  }) {
    emit(ShopImageMenuIntStates());
    FirebaseStorage.instance.ref().child('shops/${Uri
        .file(pickedFile2!.path)
        .pathSegments
        .last}').putFile(pickedFile2!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl2 = value;
        createMenu(
          desc:desc,
          category:category ,
          price: price,
          image: imageUrl2,
          name: name, foodType:foodType, restaurant: restaurant,
        );
        pickedFile2 = null;

        emit(ShopImageMenuSuccessStates())
        ;
      }).catchError((error) {
        emit(ShopImageMenuErrorStates(error));
      });
    }).catchError((error) {
      emit(ShopImageMenuErrorStates(error));
    });
  }

  void createMenu({
    required String category,
    required String image,
    required String name,
    required String price,
    required String foodType,
    required String restaurant,
    required String desc,
  }) {
    ItemModel model=ItemModel(
        name: name,
        publisherId: ud,
        image: image,
      price: price,
        desc: desc
       );
    FirebaseFirestore.instance.collection(category).doc(foodType).collection(foodType).doc(ud).collection("menu").doc(name+price).set(model.Tomap()).then((value) {

               category=='food'? getFoodMenu(foodType,restaurant):getMarketMenu(foodType, restaurant);
      emit(ShopCreateFoodMenuSuccessState());
    }).catchError((error) {
      emit(ShopCreateShopMenuErrorState(error.toString()));});}
  List<ItemModel> foodMenu=[];
  void getFoodMenu(String type,String restaurant){
    emit(GetFoodMenuLoadingState());
    foodMenu.clear();
    FirebaseFirestore.instance.collection("food").doc(type).collection(type).doc(ud).collection('menu').get().then((value) {
        for (var element in value.docs) {
          foodMenu.add(ItemModel.fromjson(element.data()));
        }

      emit(GetFoodMenuSuccessState(type,restaurant));

    });
  }
  List<ItemModel> marketMenu=[];
  void getMarketMenu(String type,String restaurant){
    emit(GetMarketMenuLoadingState());
    marketMenu.clear();
    FirebaseFirestore.instance.collection("market").doc(type).collection(type).doc(ud).collection('menu').get().then((value) {
      for (var element in value.docs) {
        marketMenu.add(ItemModel.fromjson(element.data()));
      }

      emit(GetFoodMenuSuccessState(type,restaurant));

    });
  }
  void deleteItem(String id ,String type,String name,String price,String restaurant){
    FirebaseFirestore.instance.collection("food").doc(type).collection(type).doc(id).collection("menu").doc(name+price).delete().then((value) {
      getFoodMenu(type,restaurant);
    });
    }
  ////////////////////location/////////////
  String ud =  CacheHelper.getData(key: 'uId');
  String latitude = '';
  String longitude = '';
  Future<void> getLocation() async {
    // Check if location permissions are granted
    if (await Permission.location.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );


      latitude = position.latitude.toString();
      longitude= position.longitude.toString();
      emit(ShopGetLocationSuccessState());

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
}