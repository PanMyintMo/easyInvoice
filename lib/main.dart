import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'module/module.dart';
import 'screen/home/Login.dart';
import 'screen/home/Register.dart';
import 'screen/mainScreen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   locator();
   final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Color.fromRGBO(86, 169, 207, 1.0)
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
          colorSchemeSeed: Color.fromRGBO(86, 169, 207, 1.0)
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
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
