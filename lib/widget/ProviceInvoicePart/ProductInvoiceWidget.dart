import 'package:flutter/material.dart';

import '../../common/ThemeHelperUserClass.dart';

class ProductInvoiceWidget extends StatefulWidget {
  const ProductInvoiceWidget({super.key});

  @override
  State<ProductInvoiceWidget> createState() => _ProductInvoiceWidgetState();
}

class _ProductInvoiceWidgetState extends State<ProductInvoiceWidget> {

  var prouductno=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(16.0),
      child: ListView(
        
        children:  [
          Row(
            children: [
              Expanded(child: Text('Product Invoice')),
              Expanded(child: ElevatedButton(onPressed: () {  }, child: Text('Print'),))
            ],
          ),
          SizedBox(height: 16,),
          Expanded(
            child: buildProductContainerForm(
              'Invoice no',
              TextInputType.phone,
              prouductno,
              validateProductField,
            ),
          ),
        ],


      ),
    );
  }
  String? validateProductField(String? value) {
    if (value!.isEmpty) {
      return 'Please fill this field!';
    }
    return null;
  }
}
