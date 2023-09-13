import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/product_invoice_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../data/responsemodel/DeliveryPart/ProductInvoiceResponse.dart';
import '../../module/module.dart';
import '../../widget/ProviceInvoicePart/ProductInvoiceWidget.dart';

class ProductInvoiceScreen extends StatefulWidget {
  const ProductInvoiceScreen({super.key});

  @override
  State<ProductInvoiceScreen> createState() => _ProductInvoiceScreenState();
}

class _ProductInvoiceScreenState extends State<ProductInvoiceScreen> {
  List<InvoiceData> invoiceData = []; // Initialize an empty list

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductInvoiceCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Product Invoice',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocConsumer<ProductInvoiceCubit, ProductInvoiceState>(
            listener: (context, state) {

          if (state is ProductInvoiceFail) {
            showToastMessage(state.error);
          }
        }, builder: (context, state) {
          if (state is ProductInvoiceLoading) {
            return const CircularProgressIndicator();
          } else if (state is ProductInvoiceSuccess) {
            final invoice = state.productInvoiceResponse;
            if (invoice.isEmpty) {
              return const Center(
                child: Text("Out of stock."),
              );
            }

            return ProductInvoiceWidget(
              isLoading: false,
              invoiceData: state.productInvoiceResponse,
            );
          } else {
            return const ProductInvoiceWidget(
              isLoading: false,
              invoiceData: [],
            );
          }
        }),
      ),
    );
  }
}
