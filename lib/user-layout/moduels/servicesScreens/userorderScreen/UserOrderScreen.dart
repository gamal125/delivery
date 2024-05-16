import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/components.dart';
import '../../../cubit/AppCubit.dart';
import '../../../cubit/states.dart';
import '../../sala/SalaPharma.dart';

class UserOrderScreen extends StatelessWidget {
  const UserOrderScreen({super.key,required this.name,required this.type });
  final String name;
  final String type;
  final String hint='الملاحظه';
  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var hintController=TextEditingController();
    var secondaryAddressController=TextEditingController();
    var typeController=TextEditingController();
    var c=AppCubit.get(context);
    return  BlocConsumer<AppCubit,AppStates>(
    builder: (context,state){
      return  Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,))],
          backgroundColor: const Color.fromRGBO(198, 0, 0, 1),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,),
        body:  GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){c.getItemImage();},
                            child: Container(
                              margin: const EdgeInsetsDirectional.all(10),
                          alignment: AlignmentDirectional.bottomCenter,
                              width: double.infinity,
                              height: 300,
                              decoration: c.pickedFiles!=null?
                              BoxDecoration(image: DecorationImage(image: FileImage(c.pickedFiles!)),
                                  border: Border.all(width: 5,color: Colors.white),
                                  borderRadius:BorderRadiusDirectional.circular(10) ) :
                               BoxDecoration(image: const DecorationImage(image: AssetImage('assets/icon/image3.png')),
                                 border: Border.all(width: 5,color: const Color.fromRGBO(70, 102, 162, 0.7)),
                                 borderRadius:BorderRadiusDirectional.circular(10),),
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
                          const SizedBox(height: 20,),
                      ],
                      ),
                    ),
                  ),
                ),
                ConditionalBuilder(
                condition:state is! ImageIntStates,
                  builder:(context)=> defaultMaterialButton(color: const Color.fromRGBO(198, 0, 0, 1),function: (){
                    if(AppCubit.get(context).userdata!=null){
                      AppCubit.get(context).addToPharmaSala(
                          nameController.text,
                          hintController.text,
                          typeController.text,
                          secondaryAddressController.text
                      );}else{
                      showToast(text: 'سجل دخول اولا', state: ToastStates.warning);
                    }
                  }, text: 'اضافة الي العربه'), fallback: (BuildContext context) {
                  return const Center(child:  CircularProgressIndicator(color:Color.fromRGBO(198, 0, 0, 1), ));  },
                )
             ,   const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:  const Color.fromRGBO(198, 0, 0, 1),
          onPressed: (){

           c.pharmaSala.isNotEmpty?  navigateTo(context, const SalaPharma()):
           showToast(text: 'العربه فارغه', state: ToastStates.warning);
            print(c.pharmaSala.length);},
          child: const Icon(Icons.shopping_cart_checkout,color: Colors.white,),
        ),
      );
    },
    listener: (context,state){

      if(state is ImageSuccessStates){
        nameController.text='';
        secondaryAddressController.text='';
        typeController.text='';
        hintController.text='';

      }
    });
  }
}
