import 'package:flutter/material.dart';

import '../../common/FormValidator.dart';
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
      padding:  const EdgeInsets.all(16.0),
      child: ListView(
        
        children:  [

          Align(
            alignment: Alignment.topRight,
              child: ElevatedButton(onPressed: () {  }, child: const Text('Print'),)),
          const SizedBox(height: 16,),
          Expanded(
            child: buildProductContainerForm(
              'Invoice no',
              TextInputType.phone,
              prouductno,
              validateField,
            ),
          ),
        ],

      ),
    );
  }

}
