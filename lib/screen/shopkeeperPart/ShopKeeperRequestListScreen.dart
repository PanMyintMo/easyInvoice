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
    return MultiBlocProvider(
      providers: [
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
      ],
      child: Scaffold(
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
        body: BlocConsumer<ShopKeeperRequestCubit, ShopKeeperRequestState>(
          listener: (context, state) {
            if (state is ShopKeeperRequestFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is ShopKeeperRequestLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShopKeeperRequestSuccess) {
              return BlocConsumer<TownshipDeleteCubit, TownshipDeleteState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteTownshipLoading) {
                  } else if (deleteState is DeleteTownshipSuccess) {
                    showToastMessage(
                        deleteState.deleteTownshipResponse.message);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<ShopKeeperRequestCubit>()
                          .shopkeeperRequestList();
                    });
                  } else if (deleteState is DeleteTownshipFail) {
                    showToastMessage(deleteState.error);
                  }
                },
                builder: (context, deleteState) {
                  final bool loading = deleteState is DeleteTownshipLoading;
                  return ShopKeeperRequestListWidget(
                    isLoading: loading,
                    shopData: state.shopRequestData,
                  );
                },
              );
            } else if (state is ShopKeeperRequestFail) {
              const ShopKeeperRequestListWidget(
                isLoading: false,
                shopData: [],
              );
              return Center(child: Text('Error: ${state.error}'));
            }

            return const ShopKeeperRequestListWidget(
                isLoading: false, shopData: []);
          },
        ),
      ),
    );
  }
}
