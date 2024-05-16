import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/model/ItemModel.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';
import 'package:orders/user-layout/cubit/states.dart';
import 'package:orders/user-layout/moduels/sala/SalaTool.dart';

import '../../../../components/components.dart';
class Tools extends StatelessWidget {
   Tools({super.key});



  @override
  Widget build(BuildContext context) {

    AppCubit.get(context).counters= List<int>.filled( AppCubit.get(context).items.length, 0);


    return  BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
      return Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],
          backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body:  Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
          child:       SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2 / 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount:  AppCubit.get(context).items.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return item( AppCubit.get(context).items[index],context,index);
                      }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:  const Color.fromRGBO(198, 0, 0, 1),
          onPressed: (){
            if(AppCubit.get(context).userdata!=null){
              AppCubit.get(context).addToolsSala();}else{
              showToast(text: 'سجل دخول اولا', state: ToastStates.warning);
            }
          },
          child: const Icon(Icons.shopping_cart_checkout,color: Colors.white,),
        ),
      );
    },
        listener: (context,state){
          if(state is AddToolSalaSuccessStates){
            var x=0;
            AppCubit.get(context).toolsSala.forEach((element) {x+= element.amount*int.parse(element.price); });
navigateTo(context, SalaTools(total: x));
          }
        });}
  Widget item(ItemModel item,context,int i)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: MediaQuery.of(context).size.height*0.15,
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
                  Text(item.desc,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                  Text('${item.price}\$'),
                ],),
              const SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  AppCubit.get(context).dec(i);
                },
                child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius:16 ,
                    child:  Icon(Icons.remove,color: Colors.white,)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Text(AppCubit.get(context).counters![i].toString(),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
              ),
              InkWell(
                onTap: (){
                  AppCubit.get(context).inc(i);
                },
                child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius:16 ,
                    child:  Icon(Icons.add,color: Colors.white,)),
              ),
            ],
          )
        ],),
    ),
  );
}
