import 'package:easy_invoice/bloc/get/ShopKeeperPart/deliver_warehouse_request_cubit.dart';
import 'package:easy_invoice/widget/ShopKeeperPart/DeliverWarehouseToShopWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit/statusChange/shopkeeper_status_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class DeliverWarehouseToShopkeeperScreen extends StatefulWidget {
  const DeliverWarehouseToShopkeeperScreen({super.key});

  @override
  State<DeliverWarehouseToShopkeeperScreen> createState() =>
      _DeliverWarehouseToShopkeeperScreenState();
}

class _DeliverWarehouseToShopkeeperScreenState
    extends State<DeliverWarehouseToShopkeeperScreen> {
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
            'Deliver Warehouse To Shopkeeper Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<DeliverWarehouseRequestCubit>(
            create: (context) {
              final cubit = DeliverWarehouseRequestCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.deliverWarehouseRequest();
              return cubit;
            },
          ),
          BlocProvider<ShopkeeperStatusCubit>(
            create: (context) => ShopkeeperStatusCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const ShopkeeperStatusScreen()));
  }
}

class ShopkeeperStatusScreen extends StatefulWidget {
  const ShopkeeperStatusScreen({super.key});

  @override
  State<ShopkeeperStatusScreen> createState() => _ShopkeeperStatusScreenState();
}

class _ShopkeeperStatusScreenState extends State<ShopkeeperStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DeliverWarehouseRequestCubit, DeliverWarehouseRequestState>(
          builder: (context, state) {
            if (state is DeliverWarehouseRequestLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is DeliverWarehouseRequestSuccess) {
              final deliverWarehouse = state.deliveryWarehouse;

              if (deliverWarehouse.isEmpty) {
                return const Center(
                  child: Text("No Data found."),
                );
              }

              return BlocConsumer<ShopkeeperStatusCubit, ShopkeeperStatusState>(
                builder: (context, deleteState) {
                  bool loading = deleteState is ShopkeeperStatusLoading;

                  return DeliverWarehouseToShopWidget(
                    deliverData: state.deliveryWarehouse, isLoading: loading,
                  );
                },
                listener: (context, deleteState) {
                  if (deleteState is ShopkeeperStatusSuccess) {
                    showToastMessage('Successful.');
                    BlocProvider.of<DeliverWarehouseRequestCubit>(context)
                        .deliverWarehouseRequest();
                  } else if (deleteState is ShopkeeperStatusFail) {
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

