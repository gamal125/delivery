import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orders/model/TaxiModel.dart';
import 'package:orders/user-layout/todo_layout.dart';
import '../../../../components/components.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';

import '../../../cubit/states.dart';
class TaxiScreen extends StatelessWidget {
   TaxiScreen({super.key, required this.latitude, required this.longitude});
 final String latitude;
 final String longitude;
  final  formKey = GlobalKey<FormState>();

  double totalPrice=0;

  double price=10;

  double dis=0;

  @override
  Widget build(BuildContext context) {

    var nameController=TextEditingController();
    var addressController=TextEditingController();
    var phoneController=TextEditingController();

    return Scaffold(
        backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(child: Text(' طلب تاكسي',style: TextStyle(color: Colors.white),),),
        elevation: 0,
      ),
      body:BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is SelectLocation){
            totalPrice=price*state.distance/1000;
            dis=state.distance/1000;
          }
          if(state is OrderSuccessState){
            navigateAndFinish(context, Home_Layout());} },
        builder:  (context,state){
          return   SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: Expanded(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(double.parse(latitude), double.parse(longitude)), // Replace with your initial position
                        zoom: 12,
                      ),
                      onTap: (latLng){
                        AppCubit.get(context).selectLocation(latLng);
                        print(latLng);

                      },

                      markers: AppCubit.get(context).markers,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[350]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.money),
                                Text('In Cash')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[350]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.alarm),
                                Text('Now')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[350]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.car_crash),
                                Text('Car')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[350]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.location_history),
                                Text('${dis.toStringAsFixed(2)} Km')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                    children: [
                                const SizedBox(height: 15,),
                               ConditionalBuilder(
                                 condition: state is! OrderLoadingState,
                                 builder:(context)=> Container(
                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Text('${totalPrice.toStringAsFixed(2)}  \$',style: TextStyle(fontSize: 22,color: Colors.white),),
                                         defaultMaterialButton(function: (){

                                           if(AppCubit.get(context).latitude!=''||AppCubit.get(context).longitude!=''){
                                             if(AppCubit.get(context).userdata!=null){
                                               AppCubit.get(context).setTaxiOrder(
                                                   totalPrice: '150',
                                                   shopName: 'taxi',
                                                   city: AppCubit.get(context).userdata!.city,
                                                   state: '1',
                                                   latitude: AppCubit.get(context).latitude,
                                                   longitude: AppCubit.get(context).longitude,
                                                   shopLatitude: '0',
                                                   shopLongitude: '0',
                                                   sala: TaxiModel(name: nameController.text,
                                                       publisherId: AppCubit.get(context).ud,
                                                       phone: phoneController.text,
                                                       price: "150",
                                                       locationLatitude: , locationLongitude: ''));
                                             }else{
                                               showToast(text: 'سجل دخول اولا', state: ToastStates.warning);
                                             }
                                           }else{
                                             AppCubit.get(context).getLocation().then((value) {
                                               if(AppCubit.get(context).userdata!=null){
                                                 AppCubit.get(context).setTaxiOrder(
                                                     totalPrice: '150',
                                                     shopName: 'taxi',
                                                     city: AppCubit.get(context).userdata!.city,
                                                     state: '1',
                                                     latitude: AppCubit.get(context).latitude,
                                                     longitude: AppCubit.get(context).longitude,
                                                     shopLatitude: '0',
                                                     shopLongitude: '0',
                                                     sala: TaxiModel(name: nameController.text,
                                                         publisherId: AppCubit.get(context).ud,
                                                         phone: phoneController.text,
                                                         price: "150",
                                                         locationLatitude: addressController.text));

                                               }else{
                                                 showToast(text: 'سجل دخول اولا', state: ToastStates.warning);
                                               }
                                             });
                                           }
                                         }, text: 'إنشاء طلب'),

                                       ],
                                     )),
                                 fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.red,),),
                               )
                              ],),
                  ),
                ),
              ],
            ),);
          },
      )
    );
  }
}