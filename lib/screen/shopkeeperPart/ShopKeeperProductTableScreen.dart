import 'package:easy_invoice/widget/ShopKeeperPart/ShopKeeperProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get/ShopKeeperPart/shop_product_list_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
class ShopKeeperProductTableScreen extends StatefulWidget {
  const ShopKeeperProductTableScreen({super.key});

  @override
  State<ShopKeeperProductTableScreen> createState() => _ShopKeeperProductTableScreenState();
}

class _ShopKeeperProductTableScreenState extends State<ShopKeeperProductTableScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ShopProductListCubit(getIt.call()); // Use getIt<ApiService>() to get the ApiService instance
        cubit.shopProductList(); // call warehouse product detail
        return cubit;
      },

      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text('Shopkeeper Product Screen',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
        body:
        BlocConsumer<ShopProductListCubit, ShopProductListState>(
          listener: (context, state) {
            if (state is ShopProductListFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is ShopProductListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShopProductListSuccess) {
              showToastMessage("Successfully Shop Product List retrieve.");
              return  ShopKeeperProductWidget(
                isLoading: false, productListItem: state.shopProductItem,

              );
            } else if (state is ShopProductListFail) {
              showToastMessage(state.error);
              return const ShopKeeperProductWidget(
                isLoading: false, productListItem: [],

              );
            }

            return const ShopKeeperProductWidget(
              isLoading: false, productListItem: [],

            );
          },
        ),
      ),
    );
  }
}
