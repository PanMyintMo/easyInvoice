import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String message, {int duration =3500} ) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    timeInSecForIosWeb: duration ~/ 1000,
    webShowClose: true,

  );
}
