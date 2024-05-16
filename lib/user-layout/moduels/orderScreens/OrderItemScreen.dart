import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/model/ItemSalaModel.dart';

import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';

class OrderItemsScreen extends StatefulWidget {
  const OrderItemsScreen({super.key});

  @override
  State<OrderItemsScreen> createState() => _OrderItemsScreenState();
}

class _OrderItemsScreenState extends State<OrderItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,  state) {},
      builder: (context, state) {
        return   Scaffold(
          appBar: AppBar(      backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,),
          body: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
            height: MediaQuery.of(context).size.height,
            child: ConditionalBuilder(
              condition: state is! GetMyOrderItemLoadingState,
              builder:(context)=> ListView.builder(
                itemCount: AppCubit.get(context).myOrdersItems.length,
                itemBuilder: (context,index)=>item(AppCubit.get(context).myOrdersItems[index]),),
              fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.red,)),

            ),

          ),
        );


      },
    );
  }
  Widget item(ItemSalaModel item){
    var totalPrice=item.amount*int.parse(item.price);
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
                    Text('${item.price}\$'),
                  ],),
                const SizedBox(width: 10,),

              ],
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Text('العدد  '),
                        Text(item.amount.toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text(
                      "${totalPrice.toString()} \$",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                  ],),
                const SizedBox(width: 10,),

              ],
            )
          ],),
      ),
    );
  }
}
