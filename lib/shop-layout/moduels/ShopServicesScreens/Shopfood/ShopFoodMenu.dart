import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/model/ItemModel.dart';
import 'package:orders/shop-layout/cubit/ShopAppCubit.dart';
import 'package:orders/shop-layout/cubit/ShopStates.dart';
import 'package:orders/shop-layout/moduels/ShopServicesScreens/Shopfood/ShopRestaurant.dart';
import '../../../../components/components.dart';
import '../../AddShop/AddMenu.dart';
class ShopFoodMenu extends StatefulWidget {
  const ShopFoodMenu({super.key,required this.foodType,
    required this.restaurant,});
  final String foodType;
  final String restaurant;


  @override
  State<ShopFoodMenu> createState() => _ShopFoodMenuState();}

class _ShopFoodMenuState extends State<ShopFoodMenu> {
  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(
     actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],
              leading: IconButton(onPressed: (){
            navigateTo(context, ShopRestaurant(type: widget.foodType));
          },
          icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
          ),
              backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          ),body:
          ConditionalBuilder(
            condition: state is!  GetFoodMenuLoadingState,
            builder:(context)=>ShopAppCubit.get(context).foodMenu.isNotEmpty? Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
            child: ListView.builder(
              itemCount:ShopAppCubit.get(context).foodMenu.length,
              itemBuilder: (BuildContext context, int index) { return item(ShopAppCubit.get(context).foodMenu[index]); },),):  Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
          child: const Center(child: Text('لا توجد عناصر حتي الان',style: TextStyle(color: Colors.grey,fontSize: 18),))),
            fallback: (BuildContext context) {return const Center(child: CircularProgressIndicator());  },
          ),

          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
            onPressed: () {
              navigateTo(context, AddMenu(name: 'اسم الصنف', price: "السعر", foodType:widget.foodType , restaurant: widget.restaurant, category: 'food',));
            },
          child: const Icon(Icons.add,color: Colors.white,),
          ),
          );
          },);
  }
  Widget item(ItemModel itemModel)=>Padding(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.13,
              width:MediaQuery.of(context).size.width*0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: NetworkImage(itemModel.image),fit: BoxFit.fill)),),
          ),
  
          Row(
            children: [
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(itemModel.name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text('${itemModel.price}\$'),
                ],),
              const SizedBox(width: 20,),
              IconButton(onPressed: (){
                ShopAppCubit.get(context).deleteItem(
                    itemModel.publisherId,
                    widget.foodType,
                    itemModel.name,
                    itemModel.price,
                    widget.restaurant);
              }, icon: const Icon(Icons.delete,color: Colors.red,)),
            ],
          )
        ],),
    ),
  );
}
