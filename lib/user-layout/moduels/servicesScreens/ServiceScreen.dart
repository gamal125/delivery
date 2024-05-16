import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/components/components.dart';
import 'package:orders/user-layout/moduels/servicesScreens/tools/tools.dart';
import 'package:orders/user-layout/moduels/servicesScreens/userorderScreen/UserOrderScreen.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import 'HavingOrder/HavingOrderScreen.dart';
import 'Taxi/TaxiScreen.dart';
import 'food/foodtype.dart';
import 'market/marketSections.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  var addressController=TextEditingController();
  String address='';
  @override
  Widget build(BuildContext context) {

    final List<String> myProducts =[
      'مطاعم',
      'صيدلية',
      'هدايا',
      'خضروات و بوقوليات',
      'مواد منزلية',
      'عندي طلب',
      'تاكسي',

    ];
    final List<String> myProductsPhotos =[
      'assets/icon/food2.png',
      'assets/icon/pharmacy.png',
      'assets/icon/gifts.png',
      'assets/icon/market.png',
      'assets/icon/home.png',
      'assets/icon/delivery.png',
      'assets/icon/taxi.png',

    ];
    final List<Function()> myProductsFunction =[
          (){navigateTo(context,const FoodType());},
          (){navigateTo(context, const UserOrderScreen(name: 'اسم العلاج', type: 'اسم صيدليه',)); },
          (){   if(AppCubit.get(context).latitude=='')
    {
    AppCubit.get(context).getLocation().then((value) {
    navigateTo(context, HaveOrderScreen(isGift: true, latitude: AppCubit.get(context).latitude, longitude:AppCubit.get(context).longitude,));
    });
    }else{
    navigateTo(context, HaveOrderScreen(isGift: true, latitude: AppCubit.get(context).latitude, longitude:AppCubit.get(context).longitude,));

    }
     },
          (){navigateTo(context, const MarketSections()); },
          (){navigateTo(context, Tools()); },
          (){
            if(AppCubit.get(context).latitude=='')
            {
              AppCubit.get(context).getLocation().then((value) {
                navigateTo(context, HaveOrderScreen(isGift: false, latitude: AppCubit.get(context).latitude, longitude:AppCubit.get(context).longitude,));
              });
            }else{
              navigateTo(context, HaveOrderScreen(isGift: false, latitude: AppCubit.get(context).latitude, longitude:AppCubit.get(context).longitude,));

            }
            },
          (){
      if(AppCubit.get(context).latitude=='')
      {
        AppCubit.get(context).getLocation().then((value) {
          navigateTo(context, TaxiScreen(
                latitude: AppCubit.get(context).latitude,
                longitude:AppCubit.get(context).longitude,));});
      }else{
        navigateTo(context,  TaxiScreen(
              latitude: AppCubit.get(context).latitude,
              longitude:AppCubit.get(context).longitude,));
           }

      },
    ];

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,  state) async {},
      builder: (context, state) {
addressController.text=AppCubit.get(context).address;
        return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.red,),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric( horizontal: 15.0),
                        child: Row(

                          children: [
                           IconButton(onPressed: (){AppCubit.get(context).getLocation();}, icon:const Icon( Icons.add_location_alt,color: Colors.green,)),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: TextField(
                                controller:addressController ,
                                readOnly: true,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 150,width: double.infinity,child: Image.asset('assets/icon/back.png',fit: BoxFit.cover,)),
                      const Text("كل ما تحتاجه في مكان واحد مع تطبيق طلبي ",style: TextStyle(

                          fontSize: 21,
                          color: Colors.white,
                          fontStyle: FontStyle.italic
                      ),),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: myProducts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              InkWell(
                                  onTap: myProductsFunction[index],
                                  child: Container(decoration:BoxDecoration(image:DecorationImage(image: AssetImage(myProductsPhotos[index]),fit: BoxFit.fitWidth)))),
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(myProducts[index],maxLines: 1,style: const TextStyle(

                                        fontSize: 18,color: Colors.white,
                                      overflow: TextOverflow.ellipsis
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
          );
      },
    );

  }
  
 }
