import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/components/components.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';
import '../../../../model/ShopModel.dart';
import '../../../cubit/states.dart';
import 'FoodMenu.dart';



class Restaurant extends StatelessWidget {
   const Restaurant({super.key,required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {


    return AppCubit.get(context).foodShops.isNotEmpty?
   BlocConsumer<AppCubit,AppStates>(
       listener: (context,state){
         if(state is GetUserFoodMenuSuccessState){
           AppCubit.get(context).counters= List<int>.filled(AppCubit.get(context).foodMenu.length, 0);
           navigateTo(context, FoodMenu(
             restaurantName: state.restaurant,
             foodType: state.type,
             shopLatitude: state.shopLatitude,
             shopLongitude: state.shopLongitude,));
         }
       },
     builder: (context,state){
     return  Scaffold(
       appBar: AppBar(
         actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],

         backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
         iconTheme: const IconThemeData(color: Colors.white),
         elevation: 0,
       ),
       body:  Container(
         height: MediaQuery.of(context).size.height,
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
                     itemCount: AppCubit.get(context).foodShops.length,
                     itemBuilder: (BuildContext ctx, index) {
                       return card(AppCubit.get(context).foodShops[index],context);
                     }),
               ),
             ],
           ),
         ),
       ),

     );
   }, )

        :

    Scaffold(appBar: AppBar(
      actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],

      backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
    ),body: Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),

      child: const Center(child: Text('! لا توجد مطاعم الان',
        style:TextStyle(fontSize:25,color: Colors.grey) ,),),
    ),
        );
  }
  Widget card(ShopModel shopModel,context)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        InkWell(
            onTap: (){

              AppCubit.get(context).getFoodMenu(
                  type,shopModel.name,
                  shopModel.uId,
              shopModel.Latitude,shopModel.Longitude);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(shopModel.name,maxLines: 1,style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,color: Colors.white
                    ),),
                  ],
                ),
            
            
              ],
            ),
          ),
        ),


      ],
    ),
  );


}
