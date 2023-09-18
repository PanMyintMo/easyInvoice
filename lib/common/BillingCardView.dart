import 'package:flutter/material.dart';

class BillingCardView extends StatelessWidget {
  final String? str1;
  final String? str2;
  final String? str3;
  final String? str4;
  final String? str5;
  final String? str6;
  final String? str7;
  final String? str8;

  const BillingCardView({
    Key? key,required this.str1,required this.str2,required this.str3,required this.str4,required this.str5,required this.str6,required this.str7,required this.str8,

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
                const Expanded(child: Text("Name ")),
                Text("$str1"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Email")),
                Text("$str2"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                Expanded(child: Text("Phone")),
                Text("$str3"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                Expanded(child: Text("Address")),
                Text("$str4"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                Expanded(child: Text("City")),
                Text("$str5"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                Expanded(child: Text("Township")),
                Text("$str6"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                Expanded(child: Text("Country")),
                Text("$str7"),
              ],
            ),
            SizedBox(height : 16),
            Row(
              children: [
                Expanded(child: Text("Zipcode")),
                Text("$str8"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
