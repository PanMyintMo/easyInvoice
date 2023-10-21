import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post/product_invoice_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../data/responseModel/DeliveryPart/ProductInvoiceResponse.dart';
import '../../module/module.dart';
import '../../widget/ProductInvoicePart/ProductInvoiceWidget.dart';

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
      child: BlocConsumer<ProductInvoiceCubit, ProductInvoiceState>(
          listener: (context, state) {
        if (state is ProductInvoiceFail) {
          showToastMessage(state.error);
        }
      }, builder: (context, state) {
        final isLoading = state is ProductInvoiceLoading;

        if (state is ProductInvoiceLoading) {
          return ProductInvoiceWidget(
            isLoading: isLoading,
            invoiceData: invoiceData,
          );
        } else if (state is ProductInvoiceFail) {
          showToastMessage(state.error);
        } else if (state is ProductInvoiceSuccess) {
          final invoice = state.productInvoiceResponse;

          if (invoice.isEmpty) {
            return const Center(
              child: Text("Product is out of stock."),
            );
          } else {
            invoiceData.addAll(invoice);
            return ProductInvoiceWidget(
              isLoading: isLoading,
              invoiceData: state.productInvoiceResponse,
            );
          }

          //   ProductInvoiceScreenWithListView(
          //   isLoading: false,
          //   invoiceData : state.productInvoiceResponse
          // );
        }
        return ProductInvoiceWidget(
          isLoading: isLoading,
          invoiceData: invoiceData,
        );
      }),
    );
  }
}
