import 'package:easy_invoice/bloc/post/ShopKeeperPart/add_request_product_shop_keeper_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        appBar: AppBar(title: const Text('ShopKeeper Request Screen')),
        body: BlocBuilder<AddRequestProductShopKeeperCubit, AddRequestProductShopKeeperState>(
          builder: (context, state) {
            if(state is AddRequestProductShopKeeperLoading){}
            else if(state is AddRequestProductShopKeeperSuccess){}
            else {

            }

            return  RequestShopKeeperWidget();
          },
        ),

      ),
    );
  }
}
