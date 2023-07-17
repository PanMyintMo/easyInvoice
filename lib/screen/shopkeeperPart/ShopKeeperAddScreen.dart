import 'package:flutter/material.dart';

import '../../widget/ShopKeeperPart/ShopKeeperWidget.dart';


class ShopKeeperScreen extends StatefulWidget {
  const ShopKeeperScreen({super.key});

  @override
  State<ShopKeeperScreen> createState() => _ShopKeeperScreenState();
}

class _ShopKeeperScreenState extends State<ShopKeeperScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white70,
            iconTheme: const IconThemeData(
              color: Colors.red, // Set the color of the navigation icon to black
            ),
            title: const Text('ShopKeeper Screen',style: TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),)),
        body: const ShopKeeperWidget());
  }
}
