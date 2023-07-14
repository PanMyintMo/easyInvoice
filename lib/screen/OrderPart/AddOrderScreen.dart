import 'package:flutter/material.dart';

import '../../widget/OrderPart/AddOrderWidget.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Add Order Screen'),),
        body: const AddOrderWidget());
  }
}
