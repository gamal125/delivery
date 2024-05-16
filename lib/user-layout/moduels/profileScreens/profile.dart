import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/components.dart';
import '../../../login/login_screen.dart';
import '../../../shared/local/cache_helper.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import '../../todo_layout.dart';
import 'ProfileDetails.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  var isChecked=false;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        if(state is LogoutSuccessState){

          CacheHelper.saveData(key: 'uId', value: '');
          AppCubit.get(context).ud='';
          AppCubit.get(context).currentIndex=0;
          navigateAndFinish(context, Home_Layout());
        }

      },
      builder: (context, state) {
        return CacheHelper.getData(key: 'uId')==null||CacheHelper.getData(key: 'uId')==''||AppCubit.get(context).userdata==null?
        Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
                width: double.infinity,
                child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              TextButton(onPressed: () {navigateTo(context, LoginScreen());},
                                child:const Text('الملف الشخصي',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Container(   width: 40,height: 45,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                  child: const Icon(Icons.person,color: Colors.white),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red.withOpacity(0.5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              TextButton(onPressed: () {},
                                child:const Text('سياسة الخصوصية',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Container(   width: 40,height: 45,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                  child: const Icon(Icons.policy,color: Colors.white),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red.withOpacity(0.5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              TextButton(onPressed: () {

                              },
                                child:const Text('تواصل معنا',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(   width: 40,height: 45,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                  child: const Icon(Icons.phone,color: Colors.white),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red.withOpacity(0.5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              TextButton(onPressed: () {
                               navigateTo(context, LoginScreen());
                              },
                                child:const Text('تسجيل دخول',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(   width: 40,height: 45,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                  child: const Icon(Icons.login_outlined,color: Colors.white),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),

              ),
            ),
          ],
        ):
        ConditionalBuilder(
          condition: state is! GetUserLoadingStates,
          builder:(context)=> Expanded(
            child: Container(
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
              width: double.infinity,
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            TextButton(onPressed: () {navigateTo(context, const ProfileDetailsScreen());},
                              child:const Text('الملف الشخصي',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(   width: 40,height: 45,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                child: const Icon(Icons.person,color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            TextButton(onPressed: () {},
                              child:const Text('سياسة الخصوصية',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(   width: 40,height: 45,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                child: const Icon(Icons.policy,color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            TextButton(onPressed: () {

                            },
                              child:const Text('تواصل معنا',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(   width: 40,height: 45,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                child: const Icon(Icons.phone,color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            TextButton(onPressed: () {
                    AppCubit.get(context).signOut();
                            },
                              child:const Text('تسجيل الخروج',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(   width: 40,height: 45,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                child: const Icon(Icons.logout_rounded,color: Colors.white),
                              ),
                            ),
                          ],
                        )),



                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator(),),
        );



      },
    );
  }



}
