import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/components.dart';
import '../../cubit/ShopAppCubit.dart';
import '../../cubit/ShopStates.dart';
import '../../Shop_todo_layout.dart';



class ShopUpdateProfileScreen extends StatelessWidget {


  final  formKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  ShopUpdateProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {


    var c= ShopAppCubit.get(context);
    imageController.text=c.userdata!.image!;
    nameController.text=c.userdata!.name!;
    phoneController.text=c.userdata!.phone!;


    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopImageSuccessStates) {
          ShopAppCubit.get(context).getUser(c.ud);
          ShopAppCubit.get(context).currentIndex=2;
          navigateAndFinish(context, ShopHome_Layout());

        }
        if (state is ShopUpdateProductSuccessStates) {
          ShopAppCubit.get(context).getUser(c.ud);
          ShopAppCubit.get(context).currentIndex=2;
          navigateAndFinish(context, ShopHome_Layout());

        }

      },
      builder: (context, state) {
        var imageo=c.userdata!.image!;
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(backgroundColor: Colors.white,iconTheme: const IconThemeData(color: Colors.blue),elevation: 0,),
          body: GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: (){
                            c.getImage2();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 300,

                            decoration: c.pickedFile2!=null?
                            BoxDecoration(image: DecorationImage(image: FileImage(c.pickedFile2!)))
                                : BoxDecoration(image:
                            imageo==''?
                            const DecorationImage(image: NetworkImage(
                                'https://www.leedsandyorkpft.nhs.uk/advice-support/wp-content/uploads/sites/3/2021/06/pngtree-image-upload-icon-photo-upload-icon-png-image_2047546.jpg')):
                            DecorationImage(image: NetworkImage(imageo) )

                            )
                            ,
                          ),
                        ) ,

                        Center(

                          child: Column(
                            children: [

                              Container(
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white24
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20,bottom:10),
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    defaultTextFormField(
                                        textDirection: TextDirection.rtl, textAlign: TextAlign.right,
                                      onTap: (){

                                      },
                                      controller: nameController,
                                      keyboardType: TextInputType.text,
                                      prefix: Icons.drive_file_rename_outline_sharp,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter name ';
                                        }
                                        return null;
                                      },
                                      label: 'الاسم',
                                      hint: 'Enter your name',
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),

                                    ////////////////////
                                    defaultTextFormField(
                                        textDirection: TextDirection.rtl, textAlign: TextAlign.right,
                                      onTap: (){

                                      },
                                      controller: phoneController,
                                      keyboardType: TextInputType.number,
                                      prefix: Icons.phone,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter phone';
                                        }
                                        return null;
                                      },
                                      label: 'رقم الهاتف',
                                      hint: 'Enter phone',
                                    ),


                                    const SizedBox(
                                      height: 20,
                                    ),

                                    ConditionalBuilder(
                                      condition:state is! ShopImageIntStates ,
                                      builder: ( context)=> Center(
                                        child: defaultMaterialButton(function: () {
                                          if (formKey.currentState!.validate()) {
                                            if(ShopAppCubit.get(context).pickedFile2!=null){
                                              ShopAppCubit.get(context).uploadProfileImage(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                email: ShopAppCubit.get(context).userdata!.email!,
                                              );}
                                            else{
                                              ShopAppCubit.get(context).updateProfile(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                email: ShopAppCubit.get(context).userdata!.email!, image: c.userdata!.image!,

                                              );
                                            }

                                          }

                                        }, text: 'نشر', radius: 20, color: Colors.indigo,),
                                      ),
                                      fallback: (context)=>const Center(child: CircularProgressIndicator(),),),

                                    const SizedBox(
                                      height: 20,
                                    ),

                                  ]),
                                ),


                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Container(
                                  height: 50,
                                  width: 170,
                                  decoration: const BoxDecoration(

                                    image:DecorationImage(image: AssetImage('assets/images/logo.png'),fit: BoxFit.scaleDown),),),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
