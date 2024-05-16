import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/components/components.dart';
import 'package:orders/model/ItemModel.dart';
import 'package:orders/user-layout/moduels/sala/SalaFood.dart';
import '../../../cubit/AppCubit.dart';
import '../../../cubit/states.dart';

class FoodMenu extends StatefulWidget {
   const FoodMenu({
     super.key,
     required this.restaurantName,
     required this.foodType,
     required this.shopLatitude,
     required this.shopLongitude,
   });
   final String restaurantName;
   final String foodType;
   final String shopLatitude;
   final String shopLongitude;

  @override
  State<FoodMenu> createState() => _FoodMenuState();}

class _FoodMenuState extends State<FoodMenu> {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is AddToSalaSuccessStates){
            AppCubit.get(context).counters=
            List<int>.filled(AppCubit.get(context).foodMenu.length, 0);
            var x=0;
            AppCubit.get(context).sala.forEach((element) {x+= element.amount*int.parse(element.price); });
            if(AppCubit.get(context).sala.isNotEmpty){
            navigateTo(context,  SalaFood(
              x,
              shopName: widget.restaurantName,
              shopLatitude: widget.shopLatitude,
              shopLongitude: widget.shopLongitude,));}
          }},
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(
                actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],
                leading: IconButton(onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                ),
                backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
          ),body: ConditionalBuilder(
            condition: true,
            builder:(context)=> Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
            child: ListView.builder(
              itemCount: AppCubit.get(context).foodMenu.length,
              itemBuilder: (BuildContext context, int index,) {
                return item(AppCubit.get(context).foodMenu[index],index);
                },),), fallback: (BuildContext context) {return const Center(child: CircularProgressIndicator()); },
          ),
            floatingActionButton: FloatingActionButton(
              backgroundColor:  const Color.fromRGBO(198, 0, 0, 1),
              onPressed: (){
                if(AppCubit.get(context).userdata!=null){
                AppCubit.get(context).addToSala();}else{
                  showToast(text: 'سجل دخول اولا', state: ToastStates.warning);
                }
            },
            child: const Icon(Icons.shopping_cart_checkout,color: Colors.white,),
            ),

          );

          },);
  }
  Widget item(ItemModel item,int i)=>Padding(
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

