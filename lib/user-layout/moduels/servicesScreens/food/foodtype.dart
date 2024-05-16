import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';
import 'package:orders/user-layout/cubit/states.dart';

import '../../../../components/components.dart';
import 'restaurant.dart';

class FoodType extends StatelessWidget {
  const FoodType({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> myProducts =[
      'وجبات سريعه',
      'وجبة افطار',
      'وجبه غداء',
      'وجبة عشاء',
      'مشاوي',
      'ايس كريم',
      'عصائر',
      'حلويات',



    ];
    final List<String> myProductsphotos =[
      'assets/icon/pizza.png',
      'assets/icon/break.png',
      'assets/icon/lunch.png',
      'assets/icon/dinner.png',
      'assets/icon/grills.png',
      'assets/icon/ice.png',
      'assets/icon/juice.png',
      'assets/icon/cake.png',

    ];


    return  BlocConsumer<AppCubit,AppStates>(
        listener:  (context,state){
          if(state is GetFoodShopsSuccessState){
            navigateTo(context, Restaurant(type: state.type,));
          }
        },
      builder: (context,state){return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],

        backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,

        title:            const Center(child: Text('الوجبات',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),

      ),
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),

        child: SingleChildScrollView(
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
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            InkWell(
                                onTap: (){AppCubit.get(context).getFoodShops(myProducts[index]);},
                                child: Container(decoration:BoxDecoration(image:DecorationImage(image: AssetImage(myProductsphotos[index]),fit: BoxFit.fitWidth)))),
                            Container(
                              color: Colors.red.withOpacity(0.7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(myProducts[index],style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,color: Colors.white
                                  ),),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );}, );
  }
}
