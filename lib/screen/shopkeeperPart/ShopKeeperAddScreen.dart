import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/delete/ShopKeeperPart/delete_shop_keeper_product_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get/ShopKeeperPart/shop_keeper_request_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/ShopKeeperPart/ShopKeeperWidget.dart';

class ShopKeeperScreen extends StatefulWidget {
  const ShopKeeperScreen({super.key});

  @override
  State<ShopKeeperScreen> createState() => _ShopKeeperScreenState();
}

class _ShopKeeperScreenState extends State<ShopKeeperScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = ShopKeeperRequestCubit(getIt
                .call()); // Use getIt<ApiService>() to get the ApiService instance
            cubit.shopkeeperRequestList(); // call warehouse product detail
            return cubit;
          },
        ),
        BlocProvider<DeleteShopKeeperProductRequestCubit>(
            create: (context) =>
                DeleteShopKeeperProductRequestCubit(getIt.call())),
      ],
      child: Scaffold(
          appBar: AppBar(
              title: Text(
                'ShopKeeper Screen',
                style: TextStyle(
                    color: AdaptiveTheme.of(context).theme.iconTheme.color,

                    fontSize: 16),
              )),
          body: BlocConsumer<ShopKeeperRequestCubit, ShopKeeperRequestState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ShopKeeperRequestLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShopKeeperRequestSuccess) {
                return BlocConsumer<DeleteShopKeeperProductRequestCubit,
                        DeleteShopKeeperProductRequestState>(
                    builder: (context, deleteShopKeeper) {
                  return ShopKeeperWidget(
                      isLoading: false, shopData: state.shopRequestData);
                }, listener: (context, state) {
                  if (state is DeleteShopKeeperProductRequestLoading) {
                  } else if (state is DeleteShopKeeperProductRequestSuccess) {
                    showToastMessage(state.deleteResponse.message);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<ShopKeeperRequestCubit>()
                          .shopkeeperRequestList();
                    });
                  } else if (state is DeleteShopKeeperProductRequestItemFail) {
                    showToastMessage(state.error);
                  }
                });
              } else if (state is ShopKeeperRequestFail) {
                showToastMessage(state.error);
                return const ShopKeeperWidget(
                  isLoading: false,
                  shopData: [],
                );
              }
              return const SizedBox();
            },
          )),
    );
  }
}
