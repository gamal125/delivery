import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../cubit/ShopAppCubit.dart';
import '../../cubit/ShopStates.dart';

class ShopOrderScreen extends StatefulWidget {
  const ShopOrderScreen({super.key});

  @override
  State<ShopOrderScreen> createState() => _ShopOrderScreenState();
}

class _ShopOrderScreenState extends State<ShopOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context,  state) {},
      builder: (context, state) {
        return  const SafeArea(
          child: Column(
            children: [Text('طلبي')],),

        );


      },
    );
  }
}
