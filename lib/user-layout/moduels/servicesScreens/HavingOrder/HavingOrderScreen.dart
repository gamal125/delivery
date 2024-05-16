import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orders/user-layout/todo_layout.dart';
import '../../../../components/components.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';
import 'dart:math';
import '../../../cubit/states.dart';
class HaveOrderScreen extends StatelessWidget {
  final  formKey = GlobalKey<FormState>();

  HaveOrderScreen({super.key,required this.isGift,required this.latitude, required this.longitude});

  final String latitude;
  final String longitude;
  final bool isGift;

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    var nameController=TextEditingController();
    var addressController=TextEditingController();
    var homeAddressController=TextEditingController();
    var phoneController=TextEditingController();
    var cNameController=TextEditingController();
    var cPhoneController=TextEditingController();
    var priceController=TextEditingController();
    var orderSizeController=TextEditingController();
    var orderTypeController=TextEditingController();
    var hintController=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        title:  isGift? const Center(child: Text('هدايا',style: TextStyle(color: Colors.white),),):
        const Center(child: Text('عندي طلب',style: TextStyle(color: Colors.white),),),
        elevation: 0,
      ),
      body:BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is HaveOrderSuccessState){
            navigateAndFinish(context, Home_Layout());
          }
        },
        builder:  (context,state){
          return   GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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

                    defaultTextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                    label: 'اسم المستلم', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                  const SizedBox(height: 5,),

                  defaultTextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                      label: 'رقم تليفون المستلم', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                  const SizedBox(height: 5,),
                  defaultTextFormField(
                      controller: cNameController,
                      keyboardType: TextInputType.text,
                      validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                      label: !isGift?'اسم صاحب الطلب':'اسم صاحب الهديا', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                  const SizedBox(height: 5,),
                  defaultTextFormField(
                      controller: cPhoneController,
                      keyboardType: TextInputType.phone,
                      validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                      label: !isGift? 'رقم تليفون صاحب الطلب': 'رقم تليفون صاحب الهديا', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                  const SizedBox(height: 5,),
                !isGift?  defaultTextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                      label:  'سعر الطلب', textDirection: TextDirection.rtl, textAlign: TextAlign.right):Container(),
                  const SizedBox(height: 5,),
                  defaultTextFormField(
                      controller: orderSizeController,
                      keyboardType: TextInputType.text,
                      validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                      label: !isGift?  'حجم الطلب':'حجم الهديا', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                  const SizedBox(height: 5,),
                  defaultTextFormField(
                      controller: orderTypeController,
                      keyboardType: TextInputType.text,
                      validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                      label: !isGift?  'نوع الطلب':'نوع الهديا', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                  const SizedBox(height: 5,),
                  defaultTextFormField(
                      controller: hintController,
                      keyboardType: TextInputType.text,
                      validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                      label: 'ملاحضات', textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                  const SizedBox(height: 5,),
                           // ConditionalBuilder(
                           //   condition: state is! HaveOrderLoadingState,
                           //   builder:(context)=> defaultMaterialButton(function: (){
                           //     int randomNumber = random.nextInt(10000) + 1;
                           //     if(AppCubit.get(context).latitude!=''||AppCubit.get(context).longitude!=''){
                           //     if(AppCubit.get(context).userdata!=null){
                           //       if(formKey.currentState!.validate()){
                           //         AppCubit.get(context).setHaveOrder(
                           //             date: DateTime.now().toString(),
                           //             customerId: AppCubit.get(context).ud,
                           //             price: priceController.text,
                           //             city: AppCubit.get(context).userdata!.city,
                           //             state: '1',
                           //             latitude: '',
                           //             longitude: '',
                           //             cLatitude: AppCubit.get(context).latitude,
                           //             cLongitude: AppCubit.get(context).longitude,
                           //             orderModel: HaveOrderModel(
                           //                 name: nameController.text,
                           //                 homeAddress: homeAddressController.text,
                           //                 orderId:randomNumber.toString(),
                           //                 cPhone: cPhoneController.text,
                           //                 address: addressController.text,
                           //                 cName: cNameController.text,
                           //                 phone: phoneController.text,
                           //                 latitude: AppCubit.get(context).latitude,
                           //                 longitude: AppCubit.get(context).longitude,
                           //                 price: isGift?'0':priceController.text,
                           //                 date: DateTime.now().toString(),
                           //                 size: orderSizeController.text,
                           //                 type: orderTypeController.text,
                           //                 hint: hintController.text,
                           //                 customerId: AppCubit.get(context).ud,
                           //                 city: AppCubit.get(context).userdata!.city,
                           //                 state: '1',
                           //
                           //             ), shopName: isGift?'هدايا':'عندي طلب'
                           //         );
                           //       }
                           //     }else{
                           //       showToast(text: 'سجل دخول اولا', state: ToastStates.warning);
                           //     }
                           //   }else{
                           //            AppCubit.get(context).getLocation().then((value) {
                           //              if(AppCubit.get(context).userdata!=null){
                           //                if(formKey.currentState!.validate()){
                           //                  AppCubit.get(context).setHaveOrder(
                           //                      date: DateTime.now().toString(),
                           //                      customerId: AppCubit.get(context).ud,
                           //                      price: priceController.text,
                           //                      city: AppCubit.get(context).userdata!.city,
                           //                      state: '1',
                           //                      latitude: '',
                           //                      longitude: '',
                           //                      cLatitude: AppCubit.get(context).latitude,
                           //                      cLongitude: AppCubit.get(context).longitude,
                           //                      orderModel: HaveOrderModel(
                           //                          name: nameController.text,
                           //                          homeAddress: homeAddressController.text,
                           //                          orderId:randomNumber.toString(),
                           //                          cPhone: cPhoneController.text,
                           //                          address: addressController.text,
                           //                          cName: cNameController.text,
                           //                          phone: phoneController.text,
                           //                          latitude: AppCubit.get(context).latitude,
                           //                          longitude: AppCubit.get(context).longitude,
                           //                          price:isGift?'0':priceController.text,
                           //                          date: DateTime.now().toString(),
                           //                          size: orderSizeController.text,
                           //                          type: orderTypeController.text,
                           //                          hint: hintController.text,
                           //                          customerId: AppCubit.get(context).ud,
                           //                          city: AppCubit.get(context).userdata!.city,
                           //                          state: '1'), shopName: isGift?'هدايا':'عندي طلب'
                           //                  );
                           //                }
                           //
                           //              }else{
                           //                showToast(text: 'سجل دخول اولا', state: ToastStates.warning);
                           //              }
                           //            });
                           //     }
                           //     }, text: 'إنشاء طلب'),
                           //   fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.red,),),
                           // )
                          ],),
              ),),

          ),
        );
          },
      )
    );
  }
}