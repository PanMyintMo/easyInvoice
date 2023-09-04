import 'package:easy_invoice/bloc/get/ShopKeeperPart/deliver_warehouse_request_cubit.dart';
import 'package:easy_invoice/widget/ShopKeeperPart/DeliverWarehouseToShopWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = DeliverWarehouseRequestCubit(getIt
                .call()); // Use getIt<ApiService>() to get the ApiService instance
            cubit.deliverWarehouseRequest(); // call warehouse product detail
            return cubit;
          },
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white70,
              iconTheme: const IconThemeData(
                color: Colors.red,
              ),
              title: const Text(
                'Deliver Warehouse To Shopkeeper Screen',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
          body: BlocConsumer<DeliverWarehouseRequestCubit,
              DeliverWarehouseRequestState>(
            listener: (context, state) {
              if (state is DeliverWarehouseRequestSuccess) {
                showToastMessage("Shopkeeper successfully retrieve.");
              } else if (state is DeliverWarehouseRequestFail) {
                showToastMessage("Shopkeeper delete fail.");
              }
            },
            builder: (context, state) {
              if (state is DeliverWarehouseRequestLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DeliverWarehouseRequestSuccess) {
                return DeliverWarehouseToShopWidget(
                  deliverData: state.deliveryWarehouse,
                );
              } else if (state is DeliverWarehouseRequestFail) {
                showToastMessage(state.error);
              }
              return const SizedBox();
            },
          )),
    );
  }
}
