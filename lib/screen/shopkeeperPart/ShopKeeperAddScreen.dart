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
        appBar: AppBar(title: const Text('ShopKeeper Screen')),
        body: ShopKeeperWidget());
  }
}
