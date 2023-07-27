import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  String payment=''; // no radio button will be selected on initial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Testing'),),
      body:      Row(
        children: [
          Expanded(
            child: RadioListTile(
              title: const Text('Cash'),
              activeColor: Colors.green,
              value: "Cash On Delivery",
              dense: true,
              groupValue: payment,
              onChanged: (value) {
                setState(() {
                  payment = value as String;
                });
              },
            ),
          ),
          Expanded(
            child: RadioListTile(
              title: const Text('KPay'),
              value: "Kpay",
              dense: true,
              activeColor: Colors.green,
              groupValue: payment,
              onChanged: (value) {
                setState(() {
                  payment = value as String;
                });
              },
            ),
          ),
          Expanded(
            child: RadioListTile(
              title: const Text('WavePay'),
              value: "Wave pay",
              dense: true,
              activeColor: Colors.green,
              groupValue: payment,
              onChanged: (value) {
                setState(() {
                  payment = value as String;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
