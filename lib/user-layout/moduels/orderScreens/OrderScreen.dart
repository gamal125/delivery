import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/components/components.dart';
import 'package:orders/model/OrderModel.dart';
import 'package:orders/user-layout/moduels/orderScreens/OrderItemScreen.dart';
import 'package:orders/user-layout/moduels/orderScreens/TaxiOrderScreen.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import 'OrderItemScreen2.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,  state) {},
      builder: (context, state) {
        return   Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height,
          child: ConditionalBuilder(
            condition: state is! GetMyOrderLoadingState,
            builder:(context)=> ListView.builder(
              itemCount: AppCubit.get(context).myOrders.length,
              itemBuilder: (context,index)=>item(AppCubit.get(context).myOrders[index]),),
            fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.red,)),

          ),

        );


      },
    );
  }
  Widget item(OrderModel order)=>InkWell(
    onTap: (){
      if(order.type=='order') {
        AppCubit.get(context).getMyOrderItems(city: order.city, customerId: order.customerId, date: order.date);
        navigateTo(context, const OrderItemsScreen());
      }else if(order.type=='delivery'){
        AppCubit.get(context).getMyOrderItems2(city: order.city, customerId: order.customerId, date: order.date);
        navigateTo(context, const OrderItemsScreen2());
      }
      else{
        AppCubit.get(context).getMyTaxiOrder(city: order.city, customerId: order.customerId, date: order.date);
        navigateTo(context, const TaxiOrderScreen());
      }

    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.15,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,children: [
      Row(children: [
        Container(decoration: const BoxDecoration(color: Colors.white,shape: BoxShape.circle),child: const Icon(Icons.watch_later,color: Colors.green,)),
        const SizedBox(width: 5,),
        Text(order.date.substring(11,16),style: TextStyle(color: Colors.grey[800]),),

      ],),
            const SizedBox(height: 5,),
            Row(
              children: [
                const Icon(Icons.calendar_month,color: Colors.green,),
                const SizedBox(width: 5,),
                Text(order.date.substring(5,11),style: TextStyle(color: Colors.grey[800]),),

              ],
            ),

          ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(order.shopName,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('${order.totalPrice} \$',style: const TextStyle(color: Colors.green),),
                      const SizedBox(height: 10,),
                    order.state=='1'?  const Text('تم الطلب',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold),):order.state=='2'? const Text('جاري تحضير الطلب'): const Text('تم توصيل الطلب'),
                    ],),
                  const SizedBox(width: 20,),
               ],
              )
            ],),
        ),
      ),
    ),
  );
}
