import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/delete/TownshipPart/township_delete_cubit.dart';
import '../../bloc/get/DeliveryManPart/fetch_all_warehouse_request_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/DeliveryPart/DeliveryManWidget.dart';

class DeliveryManScreen extends StatefulWidget {
  const DeliveryManScreen({super.key});

  @override
  State<DeliveryManScreen> createState() => _DeliveryManScreenState();
}

class _DeliveryManScreenState extends State<DeliveryManScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchAllWarehouseRequestCubit>(
          create: (context) {
            final cubit = FetchAllWarehouseRequestCubit(
              getIt.call(),
            ); // Use getIt<ApiService>() to get the ApiService instance
            cubit.fetchAllWarehouseRequest();
            return cubit;
          },
        ),
        BlocProvider<TownshipDeleteCubit>(
          create: (context) => TownshipDeleteCubit(
            getIt.call(),
          ), // Use getIt<ApiService>() to get the ApiService instance
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
            'Receive Product from warehouse screen',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocConsumer<FetchAllWarehouseRequestCubit, FetchAllWarehouseRequestState>(
          listener: (context, state) {
            if (state is FetchAllWarehouseRequestFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is FetchAllWarehouseRequestLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllWarehouseRequestSuccess) {
              return DeliveryManWidget(
               delivery: state.deliveryItemData, // Use state.request from warehouse to pass the data to DeliveryManWidget
              );
            } else if (state is FetchAllWarehouseRequestFail) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const SizedBox(); // Return an empty SizedBox if none of the states match
          },
        ),
      ),
    );
  }
}
