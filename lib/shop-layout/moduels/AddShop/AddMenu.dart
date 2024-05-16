import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/components.dart';
import '../../cubit/ShopAppCubit.dart';
import '../../cubit/ShopStates.dart';


class AddMenu extends StatelessWidget {
   AddMenu({super.key,
     required this.foodType,
     required this.category,
     required this.restaurant,
     required this.name,required this.price});
final String name;
  final String price;
   final String foodType;
   final String category;
   final String restaurant;
  final  formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    var nameController=TextEditingController();
    var priceController=TextEditingController();
    var descController=TextEditingController();
    var c=ShopAppCubit.get(context);
    return  BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state){

          if(state is GetFoodMenuSuccessState){
            Navigator.pop(context);
          }
        },
      builder: (context,state){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body:GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),

            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          c.getImage2();
                        },
                        child: Container(
                          margin: const EdgeInsetsDirectional.all(10),
                          alignment: AlignmentDirectional.bottomCenter,
                          width: double.infinity,
                          height: 300,
                          decoration: c.pickedFile2!=null?
                          BoxDecoration(image: DecorationImage(image: FileImage(c.pickedFile2!)),
                              border: Border.all(width: 5,color: Colors.white),

                              borderRadius:BorderRadiusDirectional.circular(10) ) :
                          BoxDecoration(image: const DecorationImage(image: AssetImage('assets/icon/image3.png')),
                            border: Border.all(width: 5,color: const Color.fromRGBO(70, 102, 162, 0.7)),


                            borderRadius:BorderRadiusDirectional.circular(10),

                          ),
                          child: const Text('انقر لاضافة صوره',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 22),),
                        ),
                      ) ,
                      const SizedBox(height: 20,),
                      defaultTextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                          label: name, textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                      const SizedBox(height: 20,),
                      defaultTextFormField(
                          controller:priceController,
                          keyboardType: TextInputType.number,
                          validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                          label: price, textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                      const SizedBox(height: 20,),
                      defaultHintTextFormField(
                          controller: descController,
                          keyboardType: TextInputType.text,
                          validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                          label: "الوصف", textDirection: TextDirection.rtl, textAlign: TextAlign.right),

                      ConditionalBuilder(
                        condition:state is! ShopImageMenuIntStates ,
                        builder:(context)=> defaultMaterialButton(function: (){
                          if(c.pickedFile2!=null){
                            if(formKey.currentState!.validate()){
                              ShopAppCubit.get(context).uploadMenuImage(
                                category: category,
                                  restaurant:restaurant,
                                  foodType: foodType,
                                  name: nameController.text,
                                  price: priceController.text,
                                  desc: descController.text);
                            }
                          }else{
                            showToast(text: 'من فضلك اضف صوره', state: ToastStates.warning);
                          }
                        }, text: 'نشر'),
                        fallback:  (context) =>
                        const Center(child: CircularProgressIndicator()),
                      )

                    ],),
                ),
              ),
            ),
          ),
        ) ,
      );
    },
    );
  }
}
