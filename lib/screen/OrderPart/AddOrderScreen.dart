import 'package:easy_invoice/bloc/post/DeliveryPart/add_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/OrderPart/AddOrderWidget.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOrderCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ), title: const Text('Add Order Screen', style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16)),),
        body: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            final loading = state is AddOrderLoading;

            if (state is AddOrderLoading) {
              return  AddOrderWidget(
                isLoading: loading,
              );
            } else if (state is AddOrderSuccess) {
              showToastMessage(state.addOrderResponse.message);
              return const AddOrderWidget(
                isLoading: false,
              );
            } else if (state is AddOrderFail) {
              showToastMessage(state.error);
              return const AddOrderWidget(
                isLoading: false,
              );
            }

            return const AddOrderWidget(
              isLoading: false,
            );
          },
        ),
      ),
    );

  }
}
