import 'package:flutter/material.dart';

class ProductCardView extends StatelessWidget {
  final String? imageUrl;
  final String? str2;
  final String? str3;
  final String? str4;

  const ProductCardView({super.key,required this.imageUrl,required this.str2,required this.str3,required this.str4,});

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

          Image.network(
            imageUrl ?? '', // Use imageUrl and provide a default value ('' in this case)
            height: 100, // Adjust the height as needed
            width: double.infinity, // Adjust the width as needed
          ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Product name")),
                Text("$str2"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Product Price")),
                Text("$str3"),
              ],
            ),
            const SizedBox(height : 16),
            Row(
              children: [
                const Expanded(child: Text("Quantity")),
                Text("$str4"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
