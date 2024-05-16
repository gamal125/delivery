// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'cubit/ShopAppCubit.dart';
import 'cubit/ShopStates.dart';



class ShopHome_Layout extends StatefulWidget {


  @override
  State<ShopHome_Layout> createState() => _ShopHome_LayoutState();
}

class _ShopHome_LayoutState extends State<ShopHome_Layout> {
var ud='';
  @override
  Widget build(BuildContext context) {
    ud=ShopAppCubit.get(context).ud;
  ud!=''&&ShopAppCubit.get(context).userdata==null?ShopAppCubit.get(context).getUser(ud):null;
    List<PreferredSizeWidget?> appBars=[
      AppBar(

        actions: [
          IconButton(onPressed: () {},icon: const Icon(Icons.shopping_cart,color: Colors.red,),),

        ],
        leading: IconButton(onPressed: () {  },icon: const Icon(Icons.search,color: Colors.red,),),
        title: const Center(child: Text("الصفحة الرئيسيه",style: TextStyle(color: Colors.red),)),elevation: 0,),
      AppBar(

        actions: [
          IconButton(onPressed: () {},icon: const Icon(Icons.shopping_cart,color: Colors.red,),),

        ],
        leading: IconButton(onPressed: () {  },icon: const Icon(Icons.search,color: Colors.red,),),
        title: const Center(child: Text("الصفحة الرئيسيه",style: TextStyle(color: Colors.red),)),elevation: 0,),
      AppBar(
        backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
        title: const Center(child: Text("الصفحة الشخصيه",style: TextStyle(color: Colors.white),)),elevation: 0,),
    ];
    String longitude=  ShopAppCubit.get(context).longitude;
    String latitude=  ShopAppCubit.get(context).latitude;

    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context,  state) async {
        if(state is ShopGetLocationSuccessState) {
          setState(() {
            longitude = ShopAppCubit.get(context).longitude;
            latitude = ShopAppCubit.get(context).latitude;
          });
          ShopAppCubit.get(context).address = await getAddressFromCoordinates(
              double.parse(latitude), double.parse(longitude),context);
        }
      },
      builder: (context, state) {
        ShopAppCubit cubit = ShopAppCubit.get(context);
        return  Scaffold(
          appBar:appBars[ShopAppCubit.get(context).currentIndex],

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:  BottomNavigationBar(
              selectedIconTheme: const IconThemeData(color:Colors.red,),
              selectedItemColor: Colors.red,
unselectedIconTheme: const IconThemeData(color: Colors.grey),
              unselectedItemColor: Colors.grey,
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },


            )

        );


      },
    );
  }
  Future<String> getAddressFromCoordinates(double latitude, double longitude,BuildContext context) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        ShopAppCubit.get(context).address = ' ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
        return  ShopAppCubit.get(context).address;
      } else {
        return 'No address found';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

}
