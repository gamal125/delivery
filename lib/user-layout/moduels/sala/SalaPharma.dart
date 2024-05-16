import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/components/components.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';
import 'package:orders/user-layout/cubit/states.dart';
import 'package:orders/user-layout/todo_layout.dart';
import '../../../model/ItemPharmaModel.dart';
class SalaPharma extends StatefulWidget {
    const SalaPharma({super.key,});
  @override
  State<SalaPharma> createState() => _SalaPharmaState();
}

class _SalaPharmaState extends State<SalaPharma> {


  @override
  Widget build(BuildContext context) {
var sala=AppCubit.get(context).pharmaSala;
    return  BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){
          if(state is OrderSuccessState){
            navigateAndFinish(context, Home_Layout());
          }
        },
        builder: (context,state){
          return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount:sala.length,
                      itemBuilder: (context,index){
                    return Dismissible(
                      onDismissed: (direction){

                        setState(() {
                          sala.removeAt(index);
                        });
                      },
                        key: ValueKey(index),
                        child: item(sala[index],context));
                  }),
                ),

                Container(width: double.infinity,height: 1,color: Colors.grey,),

                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0,top: 5),
                  child:ConditionalBuilder(condition: state is! OrderLoadingState, builder: (BuildContext context) {
                   return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        defaultMaterialButton(function: (){
                          if(AppCubit.get(context).pharmaSala.isNotEmpty){
                            if(AppCubit.get(context).latitude!=''||AppCubit.get(context).longitude!=''){
                               AppCubit.get(context).setPharmaOrder(
                                   totalPrice: '0',
                                   date: DateTime.now().toString(),
                                   customerId: AppCubit.get(context).ud,
                                   shopName:  AppCubit.get(context).pharmaSala.first.pharmaName,
                                   city: AppCubit.get(context).userdata!.city,
                                   state: '1',
                                   latitude: AppCubit.get(context).latitude,
                                   longitude: AppCubit.get(context).longitude,
                                   shopLatitude: AppCubit.get(context).latitude,
                                   shopLongitude:AppCubit.get(context).longitude);
                            }else{
                              AppCubit.get(context).getLocation().then((value) {
                                AppCubit.get(context).setPharmaOrder(
                                    totalPrice: '0',
                                    date: DateTime.now().toString(),
                                    customerId: AppCubit.get(context).ud,
                                    shopName:  AppCubit.get(context).pharmaSala.first.pharmaName,
                                    city: AppCubit.get(context).userdata!.city,
                                    state: '1',
                                    latitude: AppCubit.get(context).latitude,
                                    longitude: AppCubit.get(context).longitude,
                                    shopLatitude: AppCubit.get(context).latitude,
                                    shopLongitude:AppCubit.get(context).longitude);
                              } );


                            }
                          }
                        }, text: 'تأكيد الطلب', color: Color.fromRGBO(198, 0, 0, 1),

                        ),

                      ],
                    );
                  }, fallback: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator(color: Colors.red,),);  },)
                )
              ],
            ),
          ),
        );},);
  }

  Widget item(ItemPharmaModel item,context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.15,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.13,
              width:MediaQuery.of(context).size.width*0.25,
              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(20),
                  image:  DecorationImage(image: NetworkImage(item.image),fit: BoxFit.fill)),),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(item.name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text(item.pharmaName.toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                  ],),
                const SizedBox(width: 10,),

              ],
            ),

          ],),
      ),
    );
  }
}
