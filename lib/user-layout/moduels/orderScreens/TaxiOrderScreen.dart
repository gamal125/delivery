import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/model/TaxiModel.dart';
import '../../../model/HaveOrderModel.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';

class TaxiOrderScreen extends StatelessWidget {
  const TaxiOrderScreen({super.key});

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
                itemCount: AppCubit.get(context).myTaxiOrders.length,
                itemBuilder: (context,index)=>item(AppCubit.get(context).myTaxiOrders[index],context),),
              fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.red,)),
            ),
          ),
        );
      },
    );
  }
  Widget item(TaxiModel item,context){
    var totalPrice=item.price;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(

        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: double.infinity,
              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(20),
                  image:  const DecorationImage(image: AssetImage('assets/icon/taxiMap.png'),fit: BoxFit.cover))
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                          Text(item.locationLatitude,style: const TextStyle(fontSize: 16,),),

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
