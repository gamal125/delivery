import 'package:flutter/material.dart';
import 'package:orders/components/components.dart';
import 'package:orders/shop-layout/Shop_todo_layout.dart';
import 'package:orders/user-layout/todo_layout.dart';

class Togle extends StatelessWidget {
  const Togle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
        defaultMaterialButton(function: (){
         navigateAndFinish(context, ShopHome_Layout());
        }, text: "صاحب محل"),
        SizedBox(height: 20,),
        defaultMaterialButton(function: (){
          navigateAndFinish(context, Home_Layout());
        }, text: " مستخدم"),
            ],
        ),
      ),
    );
  }
}
