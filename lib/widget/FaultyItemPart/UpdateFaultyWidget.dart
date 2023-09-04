import 'package:flutter/material.dart';

import '../../common/ThemeHelperUserClass.dart';

class UpdateFaultyWidget extends StatefulWidget {
  final int quantity;
  final int id;

  const UpdateFaultyWidget({super.key, required this.quantity, required this.id});

  @override
  State<UpdateFaultyWidget> createState() => _UpdateFaultyWidgetState();
}

class _UpdateFaultyWidgetState extends State<UpdateFaultyWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      // children: [
      //   Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: SingleChildScrollView(
      //       child: Form(
      //         key: _formKey,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Align(
      //               alignment: Alignment.topRight,
      //               child: ElevatedButton(
      //                 onPressed: () {
      //                   // Navigator.push(
      //                   //     context,
      //                   //     MaterialPageRoute(
      //                   //         builder: (context) =>
      //                   //         const ShopKeeperScreen()));
      //                 },
      //                 child: const Text('All ShopKeeper'),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 24,
      //             ),
      //             const Text('Category'),
      //             const SizedBox(
      //               height: 16,
      //             ),
      //             SizedBox(
      //               width: double.infinity,
      //               ctemIdForm(
      //                 DropdownButton<String>(
      //                   value: category_id,
      //                   items: [
      //                     ...categories.map((category) {
      //                       return DropdownMenuItem<String>(
      //                         value: category.id.toString(),
      //                         child: Text(category.name),
      //                       );
      //                     }).toList(),
      //                   ],
      //                   onChanged: (value) async {
      //                     await fetchProductsByCategory(int.parse(value!));
      //                     setState(() {
      //                       category_id = value;
      //                       product_id = ''; // Reset product_id
      //                     });
      //                   },
      //                   underline: const SizedBox(),
      //                   borderRadius: BorderRadius.circular(10),
      //                   icon: const Icon(Icons.arrow_drop_down),
      //                   iconSize: 24,
      //                   isExpanded: true,
      //                   dropdownColor: Colors.white,
      //                   style: const TextStyle(
      //                     color: Colors.black,
      //                     fontSize: 16,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 16,
      //             ),
      //             const Text('Product'),
      //             const SizedBox(
      //               height: 16,
      //             ),
      //             SizedBox(
      //               width: double.infinity,
      //               child: chooseItemIdForm(
      //                 DropdownButton<String>(
      //                   value: product_id.isNotEmpty ? product_id : null,
      //                   items: [
      //                     ...products.map((product) {
      //                       return DropdownMenuItem<String>(
      //                         value: product.id.toString(),
      //                         child: Text(product.name),
      //                       );
      //                     }).toList(),
      //                   ],
      //                   onChanged: (value) {
      //                     setState(() {
      //                       product_id = value!;
      //                     });
      //                   },
      //                   hint: const Text('Select Product'),
      //                   underline: const SizedBox(),
      //                   borderRadius: BorderRadius.circular(10),
      //                   icon: const Icon(Icons.arrow_drop_down),
      //                   iconSize: 24,
      //                   isExpanded: true,
      //                   dropdownColor: Colors.white,
      //                   style: const TextStyle(
      //                     color: Colors.black,
      //                     fontSize: 16,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 16,
      //             ),
      //             const Text('Quantity'),
      //             const SizedBox(
      //               height: 16,
      //             ),
      //             SizedBox(
      //               width: double.infinity,
      //               child: buildProductContainerForm(
      //                 'Quantity',
      //                 TextInputType.number,
      //                 quantity,
      //                 validateField,
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 16,
      //             ),
      //             Center(
      //               child: ElevatedButton(
      //                 onPressed: validateAndSubmit,
      //                 child: const Text('Update ShopKeeper'),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }

  // void validateAndSubmit() async {
  //   if (_formKey.currentState!.validate()) {
  //     final requestModel = EditRequestModel(
  //       product_id: product_id,
  //       quantity: quantity.text,
  //     );
  //     context
  //         .read<UpdateShopKeeperCubit>()
  //         .updateShopKeeper(requestModel,widget.id);
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: const Text('Please fill in all the required fields.'),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
}
