import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/get/WarehousePart/warehouse_product_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/WarehousePart/WarehouseTableWidget.dart';
import '../shopkeeperPart/ShopKeeperRequestListScreen.dart';

class WarehouseTableScreen extends StatelessWidget {
  const WarehouseTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final cubit = WarehouseProductListCubit(getIt.call());
        cubit.warehouseProductList();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AdaptiveTheme.of(context).theme.iconTheme.color,
          ),
          title:  Text(
            'Warehouse Table Screen',
            style: TextStyle(
              color: AdaptiveTheme.of(context).theme.iconTheme.color,
              fontSize: 16,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShopKeeperRequestListScreen(),
                    ),
                  );
                },
                child:  Text(
                  "Requesting Products",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AdaptiveTheme.of(context).theme.iconTheme.color,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
            )
          ],
        )),
      ),
    );
  }
}
