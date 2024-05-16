import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/components/components.dart';
import 'package:orders/model/ShopModel.dart';
import 'package:orders/shop-layout/cubit/ShopAppCubit.dart';
import 'package:orders/shop-layout/cubit/ShopStates.dart';
import 'package:orders/shop-layout/moduels/ShopServicesScreens/Shopfood/foodtype.dart';
import '../../AddShop/AddShop.dart';
import 'ShopFoodMenu.dart';
class ShopRestaurant extends StatelessWidget {
  const ShopRestaurant({super.key,required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return  ShopAppCubit.get(context).mYFoodShop==null?
    Scaffold(appBar: AppBar(
      actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],

      leading: IconButton(onPressed: (){
        navigateTo(context, const ShopFoodType());
      },
        icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
      ),
      backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
    ),body: Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
      child: const Center(child: Text('! أضف مطعمك الان',
        style:TextStyle(fontSize: 30,color: Colors.grey) ,),),),
    floatingActionButton: FloatingActionButton(onPressed: () {
      if(ShopAppCubit.get(context).userdata!=null) {
        navigateTo(context, AddShop(name: 'اسم المطعم', type: type, category: 'food',));}
      else{showToast(text: 'سجل دخول اولا', state: ToastStates.warning);}

      },backgroundColor: const Color.fromRGBO(198, 0, 0, 1),child: const Icon(Icons.add,color: Colors.white,),
    )):
   BlocConsumer<ShopAppCubit,ShopAppStates>(
       listener: (context,state){


       },
       builder: (context,state){return  Scaffold(
     appBar: AppBar(
       actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],

       leading: IconButton(onPressed: (){
         navigateTo(context, const ShopFoodType());},
         icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
       ),
       backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
       iconTheme: const IconThemeData(color: Colors.white), elevation: 0,),
     body:Container(
       height: MediaQuery.of(context).size.height,
       decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
       child:Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.only(top: 0.0,left: 10,right: 10),
             child: GridView.builder(
                 physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 1,
                     childAspectRatio: 2 / 2,
                     crossAxisSpacing: 20,
                     mainAxisSpacing: 20),
                 itemCount: 1,
                 itemBuilder: (BuildContext ctx, index) {
                   return card(ShopAppCubit.get(context).mYFoodShop!,context);
                 }),),],),),);},
       );
  }
  Widget card(ShopModel shopModel,context)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        InkWell(
            onTap: (){
              ShopAppCubit.get(context).getFoodMenu(type,shopModel.name);
              navigateTo(context, ShopFoodMenu(foodType: type, restaurant: shopModel.name,));

            },
            child: Container(decoration:BoxDecoration(image:DecorationImage(image: NetworkImage(shopModel.image),fit: BoxFit.cover)))),
        Container(
          color: Colors.red.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star,color: Color.fromRGBO(255, 215, 0, 1),),
                    Text(shopModel.rate,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,color: Colors.white
                    ),),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(shopModel.name,maxLines: 1,style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,color: Colors.white
                      ),),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),


      ],
    ),
  );

}
