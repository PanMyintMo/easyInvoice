import 'package:easy_invoice/bloc/get/WarehousePart/warehouse_product_list_cubit.dart';
import 'package:easy_invoice/common/ToastMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../module/module.dart';
import '../../widget/WarehousePart/WarehouseTableWidget.dart';

class WarehouseTableScreen extends StatefulWidget {
  const WarehouseTableScreen({super.key});

  @override
  State<WarehouseTableScreen> createState() => _WarehouseTableScreenState();
}

class _WarehouseTableScreenState extends State<WarehouseTableScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = WarehouseProductListCubit(getIt.call()); // Use getIt<ApiService>() to get the ApiService instance
        cubit.warehouseProductList(); // call warehouse product detail
        return cubit;
      },

      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text('Warehouse Table Screen',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
        body:
            BlocConsumer<WarehouseProductListCubit, WarehouseProductListState>(
          listener: (context, state) {
            if (state is WarehouseProductListFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is WarehouseProductListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WarehouseProductListSuccess) {
              showToastMessage("Successfully Warehouse data retrieve.");
              return WarehouseTableWidget(
                isLoading: false,
                warehouseData: state.warehouseData,
              );
            } else if (state is WarehouseProductListFail) {
              showToastMessage(state.error);
              return const WarehouseTableWidget(
                isLoading: false,
                warehouseData: [],
              );
            }

            return const WarehouseTableWidget(
              isLoading: false,
              warehouseData: [],
            );
          },
        ),
      ),
    );
  }
}
