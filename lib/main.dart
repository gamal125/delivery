import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orders/register/cubit/cubit.dart';
import 'package:orders/shared/local/bloc_observer.dart';
import 'package:orders/shared/local/cache_helper.dart';
import 'package:orders/shop-layout/cubit/ShopAppCubit.dart';
import 'package:orders/togel.dart';
import 'package:orders/user-layout/cubit/AppCubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'login/cubit/maincubit.dart';
import 'login/login_screen.dart';
const apiKey = 'AIzaSyBzOopAU2qUHjFFTIpxOYyM27r_AYvQJHo';
 main() async {
   Widget widget;
   Bloc.observer = MyBlocObserver();
   WidgetsFlutterBinding.ensureInitialized();
   await getLocation();
  await CacheHelper.init();
  await Firebase.initializeApp();
  var uId=CacheHelper.getData(key: 'uId');
  if(uId != null&&uId!=''){

    widget=SplashScreenView(
      duration: 5000,
      pageRouteTransition: PageRouteTransition.SlideTransition,
      navigateRoute:   const Togle(),
      text: 'Welcome Dear',
      textType: TextType.ColorizeAnimationText,
      textStyle:  const TextStyle(fontSize: 40, fontWeight: FontWeight.w700,));
  }
  else{
    widget=SplashScreenView(
      duration: 2000,
      pageRouteTransition: PageRouteTransition.SlideTransition,
      navigateRoute:  LoginScreen(),
      text: 'Welcome',
      textType: TextType.ColorizeAnimationText,
      textStyle:  const TextStyle(fontSize: 40,fontWeight: FontWeight.w700,) ,);
  }
  runApp( MyApp(startWidget: widget));
 }


class MyApp extends StatelessWidget {
  const MyApp({super.key,   required this.startWidget});
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AppCubit()..getUsers()..getLocation()),
        BlocProvider(create: (context) => ShopAppCubit()..getLocation()),
        BlocProvider(create: (context) => RegisterCubit()),
                ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: GoogleFonts.rakkas().fontFamily,

    ),
        debugShowCheckedModeBanner: false,
        home: startWidget,),
    );
  }
}

String latitude = '';
String longitude = '';

Future<void> getLocation() async {

  if (await Permission.location.isGranted) {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
    latitude = position.latitude.toString();
    longitude= position.longitude.toString();


  } else {
    // Request location permissions
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      // Permission granted, retrieve location
      await getLocation();
    } else {
      // Permission denied
      latitude = '';

    }
  }
}