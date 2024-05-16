// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'cubit/AppCubit.dart';
import 'cubit/states.dart';



class Home_Layout extends StatefulWidget {


  @override
  State<Home_Layout> createState() => _Home_LayoutState();
}

class _Home_LayoutState extends State<Home_Layout> {
var ud='';
  @override
  Widget build(BuildContext context) {
    ud=AppCubit.get(context).ud;
  ud!=''&&AppCubit.get(context).userdata==null?AppCubit.get(context).getUser(ud):null;
    List<PreferredSizeWidget?> appBars=[
      AppBar(

        actions: [
          IconButton(onPressed: () {},icon: const Icon(Icons.shopping_cart,color: Colors.red,),),

        ],
        leading: IconButton(onPressed: () {  },icon: const Icon(Icons.search,color: Colors.red,),),
        title: const Center(child: Text("الصفحة الرئيسيه",style: TextStyle(color: Colors.red),)),elevation: 0,),
      AppBar(

        actions: [
          IconButton(onPressed: () {},icon: const Icon(Icons.shopping_cart,color: Colors.white,),),

        ],
        leading: IconButton(onPressed: () {  },icon: const Icon(Icons.search,color: Colors.white,),),
        backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
        title: const Center(child: Text(" طلباتي",style: TextStyle(color: Colors.white),)),elevation: 0,),
      AppBar(
        backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
        title: const Center(child: Text("الصفحة الشخصيه",style: TextStyle(color: Colors.white),)),elevation: 0,),
    ];
    String longitude=  AppCubit.get(context).longitude;
    String latitude=  AppCubit.get(context).latitude;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,  state) async {
        if(state is GetLocationSuccessState) {
          setState(() {
            longitude = AppCubit.get(context).longitude;
            latitude = AppCubit.get(context).latitude;
          });
          AppCubit.get(context).address = await getAddressFromCoordinates(
              double.parse(latitude), double.parse(longitude),context);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return  Scaffold(
          appBar:appBars[AppCubit.get(context).currentIndex],

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
        AppCubit.get(context).address = ' ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
        return  AppCubit.get(context).address;
      } else {
        return 'No address found';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

}
