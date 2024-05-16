import 'package:flutter/material.dart';
class ShopTools extends StatelessWidget {
  const ShopTools({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> myProducts =[
      'مستلزمات  الاخلاص',
      'مستلزمات الاصدقاء',
      'مستلزمات دارك',
      'مستلزمات الاصيل',
      'مستلزمات العروبه',
      'مستلزمات الاصدقاء',
      'مستلزمات الامل',
    ];
    final List<String> myProductsRate =[
      '5.0',
      '4.5',
      '4.0',
      '3.5',
      '3.0',
      '2.5',
      '2.0',
    ];
    final List<String> myProductsPhotos =[
      'assets/icon/t1.png',
      'assets/icon/t.png',
      'assets/icon/t2.png',
      'assets/icon/t3.png',
      'assets/icon/t1.png',
      'assets/icon/t.png',
      'assets/icon/t2.png',
      'assets/icon/t3.png',

    ];
    return  Scaffold(
        appBar: AppBar(
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
                   return card(myProducts[index],myProductsPhotos[index],myProductsRate[index]);
                 }),
           ),
         ],
       ),
     ),
      ),

    );}
  Widget card(String name,String image,String rate)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer, child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        InkWell(
            onTap: (){},
            child: Container(decoration:BoxDecoration(image:DecorationImage(image: AssetImage(image),fit: BoxFit.cover)))),
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
                    Text(rate,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,color: Colors.white
                    ),),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(name,maxLines: 1,style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,color: Colors.white
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
  );}
