import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/delete/TownshipPart/township_delete_cubit.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Requesting Product from ShopKeeper',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
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
          BlocProvider<TownshipDeleteCubit>(
            create: (context) => TownshipDeleteCubit(getIt
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

              return BlocConsumer<TownshipDeleteCubit, TownshipDeleteState>(
                builder: (context, deleteState) {
                  bool loading = deleteState is DeleteTownshipLoading;

                  return ShopKeeperRequestListWidget(
                    isLoading: loading,
                    shopData: state.shopRequestData,
                  );
                },
                listener: (context, deleteState) {
                  if (deleteState is DeleteTownshipSuccess) {
                    showToastMessage('Deleted City successful.');
                    BlocProvider.of<ShopKeeperRequestCubit>(context)
                        .shopkeeperRequestList();
                  } else if (deleteState is DeleteTownshipFail) {
                    showToastMessage(
                        'Failed to delete city: ${deleteState.error}');
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
