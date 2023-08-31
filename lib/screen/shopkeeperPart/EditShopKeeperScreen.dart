import 'package:easy_invoice/widget/ShopKeeperPart/EditShopKeeperWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/ShopKeeperPart/update_shop_keeper_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class UpdateShopKeeperScreen extends StatelessWidget {
  final int id;
  final String shopProductId;
  final String categoryId;
  final String quantity;


  const UpdateShopKeeperScreen( {super.key, required this.id, required this.quantity, required this.categoryId, required this.shopProductId, });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateShopKeeperCubit(getIt.call()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Update ShopKeeper Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<UpdateShopKeeperCubit, UpdateShopKeeperState>(
          builder: (context, state) {
            if (state is UpdateShopKeeperLoading ) {
             return const Center(child: CircularProgressIndicator());
            }
            else if (state is  UpdateShopKeeperSuccess) {
              showToastMessage(state.updateShopkeeper.message);
              return  EditShopKeeperWidget(isLoading: false, quantity: quantity.toString(), shCategoryId: categoryId, shProductId: shopProductId, );
            }
            else if (state is UpdateShopKeeperFail) {
              showToastMessage(state.error);
              return  EditShopKeeperWidget(isLoading: false, quantity: '', shCategoryId: categoryId, shProductId: shopProductId,);
            }
            return  EditShopKeeperWidget(isLoading: false, quantity: quantity.toString(), shCategoryId: categoryId, shProductId: shopProductId,);
          },
        ),
      ),
    );
  }
}
