import 'package:easy_invoice/bloc/get/Invoice/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import 'InvoiceWidget.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = InvoiceCubit(getIt
            .call()); // Use getIt<ApiService>() to get the ApiService instance
        cubit.generateInvoice();
        return cubit;
      },
      child: BlocBuilder<InvoiceCubit, InvoiceState>(
          builder: (context, state) {
            final loading = state is InvoiceLoading;
            if (state is InvoiceLoading) {
              return const Center(child:  CircularProgressIndicator());
            } else if (state is InvoiceSuccess) {
              return InvoiceWidget(
                isLoading: loading,
                invoice: state.invoice.data!,
              );
            } else if (state is InvoiceFail) {
              showToastMessage(state.error);
            }

            return const SizedBox();
          },
        ),
      );

  }
}
