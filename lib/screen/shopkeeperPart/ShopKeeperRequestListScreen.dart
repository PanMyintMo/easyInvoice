import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/edit/statusChange/warehouse_manager_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get/ShopKeeperPart/shop_keeper_request_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/ShopKeeperPart/ShopKeeperRequestListWidget.dart';

class ShopKeeperRequestListScreen extends StatefulWidget {
  const ShopKeeperRequestListScreen({super.key});

  @override
  State<ShopKeeperRequestListScreen> createState() =>
      _ShopKeeperRequestListScreenState();
}

class _ShopKeeperRequestListScreenState
    extends State<ShopKeeperRequestListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:  IconThemeData(
            color: AdaptiveTheme.of(context).theme.iconTheme.color // Set the color of the navigation icon to black
          ),
          title: Text(
            'Requesting Product from ShopKeeper',
            style: TextStyle(
                color: AdaptiveTheme.of(context).theme.iconTheme.color,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<ShopKeeperRequestCubit>(
            create: (context) {
              final cubit = ShopKeeperRequestCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.shopkeeperRequestList();
              return cubit;
            },
          ),
          BlocProvider<WarehouseManagerStatusCubit>(
            create: (context) => WarehouseManagerStatusCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const RequestProductScreen()));
  }
}

class RequestProductScreen extends StatefulWidget {
  const RequestProductScreen({super.key});

  @override
  State<RequestProductScreen> createState() => _RequestProductScreenState();
}

class _RequestProductScreenState extends State<RequestProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ShopKeeperRequestCubit, ShopKeeperRequestState>(
          builder: (context, state) {
            if (state is ShopKeeperRequestLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShopKeeperRequestSuccess) {
              final shopData = state.shopRequestData;

              if (shopData.isEmpty) {
                return const Center(
                  child: Text("No Data found."),
                );
              }

              return BlocConsumer<WarehouseManagerStatusCubit, WarehouseManagerStatusState>(
                builder: (context, deleteState) {
                  bool loading = deleteState is WarehouseManagerStatusLoading;

                  return ShopKeeperRequestListWidget(
                    isLoading: loading,
                    shopData: state.shopRequestData,
                  );
                },
                listener: (context, deleteState) {
                  if (deleteState is WarehouseManagerStatusSuccess) {
                   // showToastMessage('Successful.');
                    BlocProvider.of<ShopKeeperRequestCubit>(context)
                        .shopkeeperRequestList();
                  } else if (deleteState is WarehouseManagerStatusFail) {
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
