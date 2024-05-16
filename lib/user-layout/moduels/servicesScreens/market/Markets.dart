import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';
import 'package:orders/user-layout/cubit/states.dart';
import '../../../../components/components.dart';
import '../../../../model/ShopModel.dart';
import 'MarketMenu.dart';

class Markets extends StatelessWidget {
  const Markets({super.key,required this.type});
final String type;
  @override
  Widget build(BuildContext context) {

    return AppCubit.get(context).marketShops.isNotEmpty?
   BlocConsumer<AppCubit,AppStates>(
       listener: (context,state){
         if(state is GetUserMarketMenuSuccessState){
           AppCubit.get(context).counters= List<int>.filled(AppCubit.get(context).marketMenu.length, 0);
           navigateTo(context, MarketMenu(market: state.market, type: state.type,));
         }
       },
     builder: (context,state){return   Scaffold(
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
                   itemCount: AppCubit.get(context).marketShops.length,
                   itemBuilder: (BuildContext ctx, index) {
                     return card(AppCubit.get(context).marketShops[index],context);
                   }),
             ),
           ],
         ),
       ),
     ),

   );},)
  :    Scaffold(appBar: AppBar(
      backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
    ),body:
    Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),

      child: const Center(child: Text('! لا توجد محلات الان',
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
              AppCubit.get(context).getMarketMenu(type,shopModel.name,shopModel.uId);

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
