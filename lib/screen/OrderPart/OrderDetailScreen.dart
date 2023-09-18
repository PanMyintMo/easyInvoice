import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_invoice/bloc/get/DeliveryManPart/fetch_all_order_detail_cubit.dart';
import 'package:easy_invoice/widget/OrderPart/OrderDetailWidget.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class OrderDetailScreen extends StatelessWidget {
  final int order_id;

  const OrderDetailScreen({Key? key, required this.order_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchAllOrderDetailCubit>(
      create: (context) {
        final cubit = FetchAllOrderDetailCubit(getIt
            .call()); // Use getIt<ApiService>() to get the ApiService instance
        cubit.fetchOrderDetail(order_id);
        return cubit;
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Order Detail Screen',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocConsumer<FetchAllOrderDetailCubit, FetchAllOrderDetailState>(
          listener: (context, state) {
            if (state is FetchAllOrderDetailSuccess) {
              showToastMessage('Order detail successfully.');
             // Navigator.pop(context, true);
            } else if (state is FetchAllOrderDetailFail) {
              showToastMessage(
                  'Failed to retrieve order details. Please try again.');
              showToastMessage('Failed to : ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is FetchAllOrderDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllOrderDetailSuccess) {
              return OrderDetailWidget(
                isLoading: false,
                orderDetailResponse: state.orderDetail,
              );
            } else if (state is FetchAllOrderDetailFail) {
              return Text(state.error);
            }
            // Return a fallback widget if needed
            return const SizedBox(); // You can return an empty container or another widget.
          },
        ),
      ),
    );
  }
}
