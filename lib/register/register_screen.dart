import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../components/components.dart';

import '../login/login_screen.dart';

import '../shared/local/cache_helper.dart';
import '../user-layout/cubit/AppCubit.dart';
import '../user-layout/todo_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class RegisterScreen extends StatefulWidget {

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final taxController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordController2 = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  late final String name ;

  late final String email ;

  late final String imageUrl ;

  late final File? profileImage;

  final pickerController = ImagePicker();
  String dropdownValue = 'بغداد';
  final items = [
     DropdownMenuItem(
      value: "بغداد",
      child: Text("بغداد",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "نينوي",
      child: Text("نينوي",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "البصرة",
      child: Text("البصرة",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "صلاح الدين",
      child: Text("صلاح الدين",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "دهوك",
      child: Text("دهوك",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "اربيل",
      child: Text("اربيل",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "السليمانية",
      child: Text("السليمانية",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "ديالي",
      child: Text("ديالي",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "واسط",
      child: Text("واسط",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "ميسان",
      child: Text("ميسان",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "ذي قار",
      child: Text("ذي قار",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "المثني",
      child: Text("دهوك",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "بابل",
      child: Text("اربيل",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "كربلاء",
      child: Text("كربلاء",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "النجف",
      child: Text("النجف",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "الانبار",
      child: Text("الانبار",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "الديوانية",
      child: Text("الديوانية",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
     DropdownMenuItem(
      value: "كركوك",
      child: Text("كركوك",style: TextStyle(color: Colors.red[800],fontSize: 22),),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
       listener: (context, state) {
        if (state is RegisterSuccessState) {

          navigateAndFinish(context, LoginScreen());
        }
        if (state is SuccessState) {
          CacheHelper.saveData(key: 'uId', value: state.uId);
           AppCubit.get(context).ud=state.uId;
          AppCubit.get(context).getUser(state.uId);

          AppCubit.get(context).currentIndex=0;
           navigateAndFinish(context, Home_Layout());
        }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(    backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,),
          body: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),

            child: Padding(
              padding: const EdgeInsets.only(top: 40.0,left: 10,right: 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('إنشاء حساب',style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Dubai',),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5,left: 5,bottom:10),
                          child: Column(children: [



                            defaultTextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'البريد الالكتروني';
                                }
                                return null;
                              },
                              label: 'البريد الالكتروني',
                              hint: 'البريد الالكتروني', textDirection: TextDirection.rtl, textAlign: TextAlign.right,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,

                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'الاسم الكامل';
                                }
                                return null;
                              },
                              label: 'الاسم الكامل',
                              hint: 'الاسم الكامل',textDirection: TextDirection.rtl, textAlign: TextAlign.right,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'رقم الهاتف';
                                }
                                return null;
                              },
                              label: 'رقم الهاتف',
                              hint: 'رقم الهاتف', textDirection: TextDirection.rtl, textAlign: TextAlign.right,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,

                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'كلمة المرور';
                                }
                                return null;
                              },
                              label: 'كلمة المرور',
                              hint: 'كلمة المرور', textDirection: TextDirection.rtl, textAlign: TextAlign.right
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              controller: passwordController2,
                              keyboardType: TextInputType.text,

                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'تاكيد كلمة المرور';
                                }
                                return null;
                              },
                              label: 'تاكيد كلمة المرور',
                              hint: 'تاكيد كلمة المرور', textDirection: TextDirection.rtl, textAlign: TextAlign.right,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: AlignmentDirectional.centerEnd,
                              decoration:  BoxDecoration(border: Border.all(width: 1,color: const Color.fromRGBO(70, 102, 162, 1),),borderRadius: BorderRadius.circular(20)),

                              child: DropdownButton<String>(
                                value: dropdownValue,
                                items: items,
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                  // Perform any additional actions based on the selected value
                                },
                              ),
                            ),
                            Text('!!لا يمكن تغير المحافظه في وقت لاحق',style: TextStyle(color: Colors.grey[800]),),
                            const SizedBox(
                              height: 10,
                            ),
                            ConditionalBuilder(
                              condition: state is! CreateUserInitialState,
                              builder: (context) => Center(
                                child: defaultMaterialButton(
                                   function: () {
                                    if (formKey.currentState!.validate()) {
                                      if(passwordController.text!=passwordController2.text){
                                        showToast(text:'كلمة المرور غير متطابقه' , state: ToastStates.error);
                                      }else{
                                        if(phoneController.text.length<10){
                                          showToast(text:'رقم الهاتف غير صحيح' , state: ToastStates.error);
                                        }else{
                                          RegisterCubit.get(context).userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: phoneController.text, city: dropdownValue,
                                          );
                                        }

                                      }

                                    }
                                   },
                                  text: 'تسجيل دخول',
                                  radius: 20, color: Colors.red,
                                ),
                              ),
                              fallback: (context) =>
                                  const Center(child: CircularProgressIndicator()),
                            ),

                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                defaultTextButton(
                                  function: () {
                                    navigateAndFinish(context, LoginScreen());
                                  },
                                  text: ' !تسجيل الدخول',
                                ),
                                const Text('هل تمتلك حساب مسبقا؟',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey),),
                              ],
                            ),

                            IconButton(onPressed: () {
                              RegisterCubit.get(context).signInWithGoogle();
                            },
                              icon:SvgPicture.asset('assets/icon/google.svg',height: 48,width: 48,),
                            ),
                          ]),
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
