import 'package:flutter/material.dart';

class CardViewProduct extends StatelessWidget {
  final String? imageUrl;
  final String? str1;
  final String? str2;
  final String? str3;
  final String? str4;
  final String? str5;
  final String? str6;
  final String? str7;
  final String? str8;
  final String? str9;
  final String? str10;
  final String? str11;
  final String? str12;
  final String? str13;
  final String? str14;
  final String? str15;
  final String? str16;
  final String? str17;


  const CardViewProduct({
    Key? key,required this.imageUrl,
    required this.str1,required this.str2,
    required this.str3,required this.str4,
    required this.str5,required this.str6,
    required this.str7,required this.str8,
   required this.str9,required this.str10,
    required this.str11,required this.str12,
    required this.str13,required this.str14,
   required this.str15,required this.str16,
    required this.str17

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
          children: [
            Image.network(
              imageUrl ?? '', // Use imageUrl and provide a default value ('' in this case)
              height: 100, // Adjust the height as needed
              width: double.infinity, // Adjust the width as needed
            ),
            const SizedBox(height : 16),

            Row(
              children: [
                const Expanded(child: Text("Product Id: ")),
                Text("$str1"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Product Name")),
                Text("$str2"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Slug Name")),
                Text("$str3"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Stock Status")),
                Text("$str4"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Regular Price")),
                Text("$str5"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Sale Price")),
                Text("$str6"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Buying Price")),
                Text("$str7"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Product Quantity")),
                Text("$str8"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("SKU")),
                Text("$str9"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Category Id")),
                Text("$str10"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Size Id")),
                Text("$str11"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Feature")),
                Text("$str12"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Updated At")),
                Text("$str13"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Created At")),
                Text("$str14"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Barcode Id")),
                Text("$str15"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Shot Description")),
                Text("$str16"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Description")),
                Text("$str17"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
