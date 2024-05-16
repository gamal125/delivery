import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders/shop-layout/Shop_todo_layout.dart';
import '../../../../components/components.dart';
import '../../cubit/ShopAppCubit.dart';
import '../../cubit/ShopStates.dart';


class AddShop extends StatelessWidget {
   AddShop({super.key,required this.name,required this.type,required this.category });
  final String name;
   final String category;
  final String type;

  final  formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();

    var c=ShopAppCubit.get(context);
    return  BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state){

          if(state is ShopCreateFoodSuccessState){
           navigateTo(context, ShopHome_Layout());
          }

        },
        builder: (context,state){
          return  Scaffold(

            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
            ),
            body:  Container(
              height: MediaQuery.of(context).size.height,
              decoration:  const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
              child: SingleChildScrollView(

                child: GestureDetector(
                  onTap: (){FocusManager.instance.primaryFocus?.unfocus();},
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(

                        children: [
                          InkWell(
                            onTap: (){c.getImage2();},
                            child: Container(
                              margin: const EdgeInsetsDirectional.symmetric(vertical: 30),
                              alignment: AlignmentDirectional.bottomCenter,
                              width: double.infinity,
                              height: 300,
                              decoration: c.pickedFile2!=null?
                              BoxDecoration(image: DecorationImage(image: FileImage(c.pickedFile2!),fit: BoxFit.fill),
                                  border: Border.all(width: 5,color: const Color.fromRGBO(70, 102, 162, 0.7)),
                                  borderRadius:BorderRadiusDirectional.circular(10) ) :
                              BoxDecoration(image: const DecorationImage(image: AssetImage('assets/icon/image3.png')),
                                border: Border.all(width: 5,color: const Color.fromRGBO(70, 102, 162, 0.7)),
                                borderRadius:BorderRadiusDirectional.circular(10),

                              ),
                              child: const Text('انقر لاضافة صوره',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 22),),
                            ),
                          ) ,
                          const SizedBox(height: 10,),
                          defaultTextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validate: (String? x ) { if(x!.isEmpty){return 'this field is required';} return null;},
                              label: name, textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                          const SizedBox(height: 10,),
                          ConditionalBuilder(
                            condition:state is! ShopImageIntStates ,
                            builder: ( context)=> Center(
                              child: defaultMaterialButton(function: () {

                                if (formKey.currentState!.validate()) {
                                  if(ShopAppCubit.get(context).pickedFile2!=null){
                                    if(ShopAppCubit.get(context).latitude!=''||ShopAppCubit.get(context).longitude!=''){
                                    ShopAppCubit.get(context).uploadFoodImage(
                                      name: nameController.text, type: type, category: category,

                                    );}else{
                                      ShopAppCubit.get(context).getLocation().then((value) {
                                        ShopAppCubit.get(context).uploadFoodImage(
                                          type: type,
                                          name: nameController.text, category: category,

                                        );
                                      } );


                                    }

                                  }
                                  else{
                                showToast(text: 'يلزم اضافة صوره', state: ToastStates.warning);
                                  }

                                }

                              }, text: 'نشر', radius: 20, color: Colors.indigo,),
                            ),
                            fallback: (context)=>const Center(child: CircularProgressIndicator(),),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
       );
  }
}
