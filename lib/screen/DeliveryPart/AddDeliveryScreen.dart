import 'package:flutter/material.dart';

import '../../widget/DeliveryPart/AddDeliveryWidget.dart';

class AddDeliveryScreen extends StatefulWidget {
  const AddDeliveryScreen({super.key});

  @override
  State<AddDeliveryScreen> createState() => _AddDeliveryScreenState();
}

class _AddDeliveryScreenState extends State<AddDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),title: const Text('Add Delivery Screen', style: TextStyle(
          color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16)),),
      body: const AddDeliveryWidget(),
    );
  }
}
