import 'package:flutter/material.dart';

import '../../widget/ProviceInvoicePart/ProductInvoiceWidget.dart';


class ProductInvoiceScreen extends StatefulWidget {
  const ProductInvoiceScreen({super.key});

  @override
  State<ProductInvoiceScreen> createState() => _ProductInvoiceScreenState();
}

class _ProductInvoiceScreenState extends State<ProductInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Invoice Screen'),),

        body: const ProductInvoiceWidget());
  }
}
