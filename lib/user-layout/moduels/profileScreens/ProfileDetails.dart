import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/user-layout/moduels/profileScreens/updateprofile.dart';
import '../../../components/components.dart';
import '../../../shared/local/cache_helper.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import '../../todo_layout.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is LogoutSuccessState){
          CacheHelper.saveData(key: 'uId', value: '');
          AppCubit.get(context).ud='';
          AppCubit.get(context).currentIndex=0;
          navigateAndFinish(context, Home_Layout());
        }

      },
       builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,

            title:const Center(child: Text('الملف الشخصي',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),

          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
                    width: double.infinity,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children:[

                                AppCubit.get(context).userdata!.image==''||AppCubit.get(context).userdata!.image==null?
                                const CircleAvatar(backgroundImage: AssetImage('assets/icon/1.jpg'),radius: 80,):
                                CircleAvatar(backgroundImage: NetworkImage(AppCubit.get(context).userdata!.image!),radius: 80,),
                                Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[100],
                                    ),
                                    child: IconButton( onPressed: (){navigateTo(context, UpdateProfileScreen()); },
                                        icon: const Icon(Icons.edit,color: Colors.red,size: 18,))),

                              ]

                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(AppCubit.get(context).userdata!.name!,
                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(   width: 40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                    child: const Icon(Icons.drive_file_rename_outline,color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("محافظة بني سويف",
                                  style: TextStyle(fontSize: 18,color: Colors.black),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(   width: 40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                    child: const Icon(Icons.location_on,color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("شارع صلاح سالم",
                                  style: TextStyle(fontSize: 18,color: Colors.black),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(   width: 40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                    child: const Icon(Icons.location_city,color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("مهندس برمجه",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(   width: 40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                    child: const Icon(Icons.work,color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(AppCubit.get(context).userdata!.phone!=''?
                                AppCubit.get(context).userdata!.phone!:'01501375000',
                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(   width: 40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                    child: const Icon(Icons.phone_android,color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(AppCubit.get(context).userdata!.email!,
                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(   width: 40,height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),

                                    child: const Icon(Icons.email,color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),






                        ],
                      ),
                    ),
                  ),
              ),
            ],
          ),
        );

      },
    );
  }
}
