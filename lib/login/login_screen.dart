
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../components/components.dart';

import '../register/register_screen.dart';
import '../shared/local/cache_helper.dart';
import '../user-layout/cubit/AppCubit.dart';
import '../user-layout/todo_layout.dart';
import 'cubit/maincubit.dart';
import 'cubit/state.dart';



class LoginScreen extends StatelessWidget {
 final  formKey = GlobalKey<FormState>();

 final emailController = TextEditingController();

 final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
         if (state is LoginSuccessState) {

            CacheHelper.saveData(key: 'uId', value: state.uId);


            AppCubit.get(context).getUser(state.uId);
            AppCubit.get(context).ud=state.uId;
            AppCubit.get(context).currentIndex=0;
                navigateAndFinish(context,  Home_Layout());



      }},
      builder: (context, state) {
        return Scaffold(

          backgroundColor: Colors.white,
          appBar: AppBar(    backgroundColor: Color.fromRGBO(198, 0, 0, 1),
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,),

          body: SafeArea(
            child: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
                },

                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/o.png'),fit: BoxFit.fill)),

                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultTextFormField(
                                onTap: (){
                                },
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefix: Icons.email,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  return null;
                                },
                                label: 'Email',
                                hint: 'Enter your email', textDirection: TextDirection.ltr, textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultTextFormField(
                                onTap: (){
                                  // LoginCubit.get(context).emit(LoginInitialState());
                                },
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                prefix: Icons.key,
                                suffix: LoginCubit.get(context).suffix,
                                isPassword: LoginCubit.get(context).isPassword,
                                suffixPressed: () {
                                  LoginCubit.get(context).ChangePassword();
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                                label: 'Password',
                                hint: 'Enter your password',textDirection: TextDirection.ltr, textAlign: TextAlign.left,
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => Center(
                                  child: defaultMaterialButton(

                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    text: 'Login',
                                    radius: 20,
                                  ),
                                ),
                                fallback: (context) =>
                                    const Center(child: CircularProgressIndicator()),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Don\'t have an account?',
                                    style:
                                        TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  defaultTextButton(
                                    function: () {
                                      navigateAndFinish(context, RegisterScreen());
                                    },
                                    text: 'Register Now!',
                                  ),
                                ],
                              ),

                              Center(
                                child: IconButton(onPressed: () {
                                  LoginCubit.get(context).signInWithGoogle();
                                },
                                  icon:SvgPicture.asset('assets/icon/google.svg',height: 48,width: 48,),
                                ),
                              ),
                            ],
                          ),
                        ),
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
