import 'package:easy_invoice/bloc/post/ShopKeeperPart/add_request_product_shop_keeper_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../widget/ShopKeeperPart/RequestShopKeeperWidget.dart';

class RequestShopKeeperScreen extends StatefulWidget {
  const RequestShopKeeperScreen({super.key});

  @override
  State<RequestShopKeeperScreen> createState() =>
      _RequestShopKeeperScreenState();
}

class _RequestShopKeeperScreenState extends State<RequestShopKeeperScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddRequestProductShopKeeperCubit(getIt.call()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'ShopKeeper Request Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<AddRequestProductShopKeeperCubit, AddRequestProductShopKeeperState>(
          builder: (context, state) {
            if (state is AddRequestProductShopKeeperLoading ) {
              return const RequestShopKeeperWidget(isLoading: true);
            }
            else if (state is  AddRequestProductShopKeeperSuccess) {
             // showToastMessage('Shopkeeper request product successfully.');
              Navigator.pop(context,true);
              return const RequestShopKeeperWidget(isLoading: false);
            }
            else if (state is AddRequestProductShopKeeperFail) {
              showToastMessage('Failed to request product. Please try again.');
              return const RequestShopKeeperWidget(isLoading: false);
            } else {
              // Initial state or unknown state
              return const RequestShopKeeperWidget(isLoading: false);
            }
          },
        ),
      ),
    );
  }
}
