import 'package:easy_invoice/bloc/edit/statusChange/delivery_man_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get/DeliveryManPart/fetch_all_warehouse_request_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/DeliveryPart/DeliveryManWidget.dart';

class DeliveryManScreen extends StatefulWidget {
  const DeliveryManScreen({super.key});

  @override
  State<DeliveryManScreen> createState() => _DeliveryManScreenState();
}

class _DeliveryManScreenState extends State<DeliveryManScreen> {
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
            'Receive Product from warehouse screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<FetchAllWarehouseRequestCubit>(
            create: (context) {
              final cubit = FetchAllWarehouseRequestCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.fetchAllWarehouseRequest();
              return cubit;
            },
          ),
          BlocProvider<DeliveryManStatusCubit>(
            create: (context) => DeliveryManStatusCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const DeliveryStatusScreen()));
  }
}

class DeliveryStatusScreen extends StatefulWidget {
  const DeliveryStatusScreen({super.key});

  @override
  State<DeliveryStatusScreen> createState() => _DeliveryStatusScreenState();
}

class _DeliveryStatusScreenState extends State<DeliveryStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FetchAllWarehouseRequestCubit, FetchAllWarehouseRequestState>(
          builder: (context, state) {
            if (state is FetchAllWarehouseRequestLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllWarehouseRequestSuccess)  {
              final deliveryItem = state.deliveryItemData;

              if (deliveryItem.isEmpty) {
                return const Center(
                  child: Text("No Data found."),
                );
              }

              return BlocConsumer<DeliveryManStatusCubit, DeliveryManStatusState>(
                builder: (context, deleteState) {
                  bool loading = deleteState is DeliveryManStatusLoading;

                  return DeliveryManWidget(
                    delivery: state.deliveryItemData, isLoading: loading, // Use state.request from warehouse to pass the data to DeliveryManWidget
                  );
                },
                listener: (context, deleteState) {
                  if (deleteState is DeliveryManStatusSuccess) {
                    showToastMessage('Successful.');
                    BlocProvider.of<FetchAllWarehouseRequestCubit>(context)
                        .fetchAllWarehouseRequest();
                  } else if (deleteState is DeliveryManStatusFail) {
                    showToastMessage(
                        'Failed to : ${deleteState.error}');
                  }
                },
              );
            } else {
              return const SizedBox(); // Handle other states if needed
            }
          },
        ),
      ],
    );
  }
}

