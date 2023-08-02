import 'package:easy_invoice/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/post/Login&Register/sign_up_cubit.dart';
import '../module/module.dart';
import 'Login&Register/Login.dart';
import 'Login&Register/Register.dart';
import 'mainscreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white),
            centerTitle: false,
            elevation: 0,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        getPages: [
          GetPage(name: "/", page: () => const SplashScreen()),
          GetPage(name: "/login", page: () => const Login()),
          GetPage(name: '/register', page: () => const Register()),
          GetPage(name: "/mainScreen", page: () => const MainPageScreen()),
        ],
        initialRoute: "/",
      ),
    );
  }
}
