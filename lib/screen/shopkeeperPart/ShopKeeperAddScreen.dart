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
    return BlocProvider(
      create: (context) {
        final cubit = ShopKeeperRequestCubit(getIt
            .call()); // Use getIt<ApiService>() to get the ApiService instance
        cubit.shopkeeperRequestList(); // call warehouse product detail
        return cubit;
      },
      child: Scaffold(
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white70,
              iconTheme: const IconThemeData(
                color: Colors
                    .red,
              ),
              title: const Text('ShopKeeper Screen', style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),)),
          body: BlocConsumer<ShopKeeperRequestCubit, ShopKeeperRequestState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              if(state is ShopKeeperRequestLoading)
                {
                  return const Center(child: CircularProgressIndicator());
                }
              else if(state is ShopKeeperRequestSuccess){
                showToastMessage("Success Shop Keeper Request");
                return  ShopKeeperWidget(isLoading: false, shopData: state.shopRequestData,);
              }
              else if(state is ShopKeeperRequestFail){
                showToastMessage(state.error);
                return  const ShopKeeperWidget(isLoading: false, shopData: [],);
              }


              return const SizedBox();
            },
          )),
    );
  }
}
