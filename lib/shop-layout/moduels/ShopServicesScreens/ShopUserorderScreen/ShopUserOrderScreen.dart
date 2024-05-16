import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/components.dart';
import '../../../cubit/ShopAppCubit.dart';
import '../../../cubit/ShopStates.dart';

class ShopUserOrderScreen extends StatelessWidget {
  const ShopUserOrderScreen({super.key,required this.name,required this.type });
  final String name;
  final String type;
  final String hint='الملاحظه';

  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var hintController=TextEditingController();
    var secondaryAddressController=TextEditingController();
    var typeController=TextEditingController();
    var c=ShopAppCubit.get(context);
    return  BlocConsumer<ShopAppCubit,ShopAppStates>(
    builder: (context,state){
      return  Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body:  GestureDetector(
          onTap: (){FocusManager.instance.primaryFocus?.unfocus();},
          child: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){c.getImage2();},
                      child: Container(
                        margin: const EdgeInsetsDirectional.all(10),
                        alignment: AlignmentDirectional.bottomCenter,
                        width: double.infinity,
                        height: 300,
                        decoration: c.pickedFile2!=null?
                        BoxDecoration(image: DecorationImage(image: FileImage(c.pickedFile2!)),
                            border: Border.all(width: 5,color: Colors.white),
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
                    defaultTextField(
                        controller: secondaryAddressController,
                        keyboardType: TextInputType.name,
                        label:'اضافة تفاصيل للعنوان ', textDirection: TextDirection.rtl, textAlign: TextAlign.right ),
                    const SizedBox(height: 10,),
                    defaultTextField(
                        controller: typeController,
                        keyboardType: TextInputType.name,
                        hint: 'ادخل اسم $type',
                        label: type, textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                    const SizedBox(height: 10,),
                    defaultHintTextFormField(
                        controller: hintController,
                        keyboardType: TextInputType.name,
                        validate: (String? x ) { if(x!.isEmpty){return 'this field is required';}return null; },

                        label: hint, textDirection: TextDirection.rtl, textAlign: TextAlign.right),

                ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    listener: (context,state){});
  }
}
