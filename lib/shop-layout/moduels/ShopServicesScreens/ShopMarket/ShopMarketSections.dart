import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/components/components.dart';
import 'package:orders/shop-layout/cubit/ShopStates.dart';

import '../../../cubit/ShopAppCubit.dart';
import 'ShopMarkets.dart';



class ShopmarketSections extends StatelessWidget {
  const ShopmarketSections({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> myProducts =[
      'خضروات ',
      'فواكه',
      'بقوليات',
      'مكسرات',


    ];

    final List<String> myProductsphotos =[
      'assets/icon/v.png',
      'assets/icon/v1.png',
      'assets/icon/v2.png',
      'assets/icon/v3.png',
      'assets/icon/v.png',
      'assets/icon/v1.png',
      'assets/icon/v2.png',
      'assets/icon/v3.png',

    ];


    return  BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state){
          if(state is GetMYMarketShopSuccessState){
            navigateTo(context, ShopMarkets(type: state.type,));
          }
        },
        builder: (context,state){return Scaffold(
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
                        itemCount: myProducts.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return card(myProducts[index],myProductsphotos[index],context);
                        }),
                  ),
                ],
              ),
            ),
          ),

        );}, );
  }
  Widget card(String name,String image,context)=>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        InkWell(
            onTap: (){
              ShopAppCubit.get(context).getMYMarketShop(name);

            },
            child: Container(decoration:BoxDecoration(image:DecorationImage(image: AssetImage(image),fit: BoxFit.fitWidth)))),
        Container(
          color: Colors.red.withOpacity(0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name,style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,color: Colors.white
              ),),
            ],
          ),
        ),


      ],
    ),
  );

}
