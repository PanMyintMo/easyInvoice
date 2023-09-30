import 'package:easy_invoice/bloc/get/DeliveryManPart/fetch_all_order_detail_cubit.dart';
import 'package:easy_invoice/widget/OrderPart/EditOrderWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit/CityPart/edit_order_detail_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class EditOrderScreen extends StatefulWidget {
  final int order_id;

  const EditOrderScreen({super.key, required this.order_id});

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(
          color: Colors.red, // Set the color of the navigation icon to black
        ),
        title: const Text(
          'Edit Order Screen',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FetchAllOrderDetailCubit>(
            create: (context) => FetchAllOrderDetailCubit(
              getIt.call(),
            )..fetchOrderDetail(widget.order_id),
          ),
          BlocProvider<EditOrderDetailCubit>(
            create: (context) => EditOrderDetailCubit(
              getIt.call(),
            ),
          ),
        ],
        child: EditOrder(
          order_id: widget.order_id,
        ),
      ),
    );
  }
}

class EditOrder extends StatefulWidget {
  final int order_id;

  const EditOrder({super.key, required this.order_id});

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAllOrderDetailCubit, FetchAllOrderDetailState>(
      builder: (context, state) {
        final loading= state   is FetchAllOrderDetailLoading || state is EditOrderDetailLoading;
        if (state is FetchAllOrderDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchAllOrderDetailSuccess) {
          final orderDetailResponse = state.orderDetail.data;
          return BlocConsumer<EditOrderDetailCubit, EditOrderDetailState>(
            builder: (context, state) {

              if (state is EditOrderDetailLoading) {
                return EditOrderWidget(
                  isLoading: loading, // No longer loading
                  orderDetailResponse: orderDetailResponse,
                );
              } else if (state is EditOrderDetailSuccess) {
                showToastMessage('Updated successful.');
                context
                    .read<FetchAllOrderDetailCubit>()
                    .fetchOrderDetail(widget.order_id);
              }
              else if(state is EditOrderDetailFail){
                showToastMessage(state.error);
              }
              return EditOrderWidget(
                isLoading: loading, // No longer loading
                orderDetailResponse: orderDetailResponse,
              );
            },
            listener: (context, state) {
              if (state is EditOrderDetailLoading) {
              } else if (state is EditOrderDetailSuccess) {
                showToastMessage('Updated successful.');
                context
                    .read<FetchAllOrderDetailCubit>()
                    .fetchOrderDetail(widget.order_id);
              } else if (state is EditOrderDetailFail) {
                showToastMessage(
                    'Failed to update order item: ${state.error}');
              }
            },
          );
        }
      return  const SizedBox();

        },
    );
  }
}
