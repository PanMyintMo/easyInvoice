import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String? id;
  final String? str1;
  final String? str2;
  final String? str3;

  const CardView({
    Key? key,
    required this.id,
    required this.str1,
    required this.str2,
    required this.str3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.greenAccent), // Add an outline border
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(10), // Add padding for spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(child: Text("Order Id: ")),
                Text("$id"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Order Date:")),
                Text("$str1"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                Expanded(child: Text("Status:")),
                Text("$str2"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                Expanded(child: Text("Delivery Date:")),
                Text("$str3"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
