import 'package:flutter/material.dart';

import '../../widget/DeliveryPart/DeliveryManWidget.dart';

class DeliveryManScreen extends StatefulWidget {
  const DeliveryManScreen({super.key});

  @override
  State<DeliveryManScreen> createState() => _DeliveryManScreenState();
}

class _DeliveryManScreenState extends State<DeliveryManScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text('Delivery Man Screen',style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16)),),
        body: const DeliveryManWidget());
  }
}
