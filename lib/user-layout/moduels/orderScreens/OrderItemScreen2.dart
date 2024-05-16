import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/HaveOrderModel.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';

class OrderItemsScreen2 extends StatelessWidget {
  const OrderItemsScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,  state) {},
      builder: (context, state) {
        return   Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,),
          body: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
            height: MediaQuery.of(context).size.height,
            child: ConditionalBuilder(
              condition: state is! GetMyOrderItemLoadingState,
              builder:(context)=> ListView.builder(
                itemCount: AppCubit.get(context).myOrdersItems2.length,
                itemBuilder: (context,index)=>item(AppCubit.get(context).myOrdersItems2[index],context),),
              fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.red,)),
            ),
          ),
        );
      },
    );
  }
  Widget item(HaveOrderModel item,context){
    var totalPrice=item.price;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: double.infinity,
              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(20),
                  image:  const DecorationImage(image: AssetImage('assets/icon/map2.png'),fit: BoxFit.cover))
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item.name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],),
                      const SizedBox(width: 10,),
                      Text("${totalPrice.toString()} \$",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const Text('العنوان',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item.cLatitude,style: const TextStyle(fontSize: 16,),),
                          Text(item.cLongitude,style: const TextStyle(fontSize: 14,),),
                        ],),
                      const SizedBox(width: 10,),

                    ],
                  ),
                ],
              ),


            ],),
        ],
      ),
    );
  }

}
