import 'package:get/get.dart';
import '../bloc/post/sign_in_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_invoice/screen/splash_screen.dart';
import '../module/module.dart';
import 'package:flutter/material.dart';


void main() {
  locator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<SignInCubit>(
        create: (context) => getIt.call(),
        child:  const SplashScreen(),
      ),
    );
  }
}


