import 'package:easy_invoice/bloc/post/sign_up_cubit.dart';
import 'package:easy_invoice/screen/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/screen/splash_screen.dart';
import 'package:easy_invoice/screen/mainscreen.dart';
import 'package:easy_invoice/screen/login.dart';

void main() {

  locator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (BuildContext context) => getIt.get<SignUpCubit>(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.pink,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.redAccent,
                // This will be applied to the "back" icon
                iconTheme: IconThemeData(color: Colors.white),
                // This will be applied to the action icon buttons that locates on the right side
                actionsIconTheme: IconThemeData(color: Colors.white),
                centerTitle: false,
                elevation: 0,
                titleTextStyle: TextStyle(color: Colors.white,fontSize: 24))),

        getPages: [
          GetPage(name: "/", page: () => const SplashScreen()), // Define SplashScreen route
          GetPage(name: "/Login", page: () => const Login()), // Define Login route
          GetPage(name: '/register', page: () => const Register()),
          GetPage(name: "/MainScreen", page: () =>  MainPageScreen()), // Define MainPageScreen route
        ],
      ),
    );
  }
}
