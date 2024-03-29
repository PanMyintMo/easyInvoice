import 'dart:async';
import 'package:easy_invoice/network/SharedPreferenceHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'home/Login.dart';
import 'mainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

     Timer(const Duration(seconds: 3), () async {
       //Check if token exists
       final token = await SessionManager().getAuthToken();

       if (token != null) {
        // Token exists, navigate to the profile page
         Get.offAll(() =>  const MainPageScreen());
       } else {
         Get.offAll(() => const Login());
       }
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Myanmar Easy Invoice',
            style: TextStyle(
                fontSize: 34, fontWeight: FontWeight.w700, color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}
