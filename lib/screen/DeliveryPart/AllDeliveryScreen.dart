import 'package:flutter/material.dart';

class AllDeliveryScreen extends StatefulWidget {
  const AllDeliveryScreen({super.key});

  @override
  State<AllDeliveryScreen> createState() => _AllDeliveryScreenState();
}

class _AllDeliveryScreenState extends State<AllDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),

          title: const Text('All Delivery Screen',style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16))),);

  }
}
