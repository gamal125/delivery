import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/components/components.dart';
import 'package:orders/model/ItemSalaModel.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';
import 'package:orders/user-layout/cubit/states.dart';
import 'package:orders/user-layout/todo_layout.dart';
class SalaTools extends StatefulWidget {
   SalaTools({required this.total,super.key,});
  int total;
  @override
  State<SalaTools> createState() => _SalaToolsState();
}

class _SalaToolsState extends State<SalaTools> {


  @override
  Widget build(BuildContext context) {
    var sala=AppCubit.get(context).toolsSala;
    var c=AppCubit.get(context);
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
                                widget.total=widget.total-sala[index].amount*int.parse(sala[index].price);
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
                            if(c.toolsSala.isNotEmpty){
                            if(c.latitude!=''||AppCubit.get(context).longitude!=''){
                              c.setOrder(
                                totalPrice: widget.total.toString(),
                                date: DateTime.now().toString(),
                                customerId: c.ud,
                                city:c.userdata!.city,
                                state: '1',
                                latitude:c.latitude ,
                                longitude: c.longitude,
                                shopName: c.toolsSala.first.name,
                                shopLatitude:c.latitude,
                                shopLongitude:c.longitude,
                                sala:c.toolsSala,)
                              ;}
                            else{
                              c.getLocation().then((value) {
                                c.setOrder(
                                    totalPrice: widget.total.toString(),
                                    date: DateTime.now().toString(),
                                    customerId: c.ud,
                                    city: c.userdata!.city,
                                    state: '1',
                                    latitude:c.latitude ,
                                    longitude:c.longitude,
                                    shopName:c.toolsSala.first.name,
                                    shopLatitude:c.latitude,
                                    shopLongitude:c.longitude,
                                    sala:c.toolsSala

                                );
                              } );


                            }
                          }
                          }, text: 'تأكيد الطلب', color: const Color.fromRGBO(198, 0, 0, 1),

                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text( "إجمالي السعر",style: TextStyle(color: Colors.grey,fontSize: 16),),
                              Text("${widget.total.toString()} \$"),
                            ],
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
  Widget item(ItemSalaModel item,context){
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

                        Text(item.amount.toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        const Text('  :العدد '),
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
