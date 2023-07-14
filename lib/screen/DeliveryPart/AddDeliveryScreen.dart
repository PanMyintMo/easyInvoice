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
      appBar: AppBar(title: const Text('Add Delivery Screen'),),
      body: const AddDeliveryWidget(),
    );
  }
}
