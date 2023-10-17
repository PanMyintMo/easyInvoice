import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomDialog({
  required String title,
  required String content,
  required String confirmText,
  required Function onConfirm,
}) {
  Get.defaultDialog(
    title: title,
    titleStyle: const TextStyle(fontSize: 20),
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(content),
    ),
    confirm: ElevatedButton(
      onPressed: () {
        onConfirm();
        Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        side: BorderSide.none,
      ),
      child: Text(confirmText),
    ),
    cancel: OutlinedButton(
      onPressed: () => Get.back(),
      child: const Text("No"),
    ),
  );
}
