import 'package:easy_invoice/bloc/delete/DeliveryPart/delete_delivery_cubit.dart';
import 'package:easy_invoice/bloc/get/DeliveryManPart/fetch_all_delivery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/DeliveryPart/FetchAllDeliveryWidget.dart';
import 'AddDeliveryScreen.dart';

class AllDeliveryScreen extends StatefulWidget {
  const AllDeliveryScreen({super.key});

  @override
  State<AllDeliveryScreen> createState() => _AllDeliveryScreenState();
}

class _AllDeliveryScreenState extends State<AllDeliveryScreen> {
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
            'All Delivery Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<FetchAllDeliveryCubit>(
            create: (context) {
              final cubit = FetchAllDeliveryCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.fetchAllDelivery();
              return cubit;
            },
          ),
          BlocProvider<DeleteDeliveryCubit>(
            create: (context) => DeleteDeliveryCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const DeliveryScreen()));
  }
}

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddDeliveryScreen(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<FetchAllDeliveryCubit>(context).fetchAllDelivery();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New Delivery',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<FetchAllDeliveryCubit, FetchAllDeliveryState>(
            builder: (context, state) {
              if (state is FetchAllDeliveryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllDeliverySuccess) {
                final delivery = state.deliveryItemData;

                if (delivery.isEmpty) {
                  return const Center(
                    child: Text("No Delivery found."),
                  );
                }

                return BlocConsumer<DeleteDeliveryCubit, DeleteDeliveryState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteDeliveryLoading;

                    return FetchAllDeliveryWidget(
                      deliveriesItem: state.deliveryItemData,isLoading: loading,
                    );
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteDeliverySuccess) {
                      showToastMessage('Deleted Delivery successful.');
                      BlocProvider.of<FetchAllDeliveryCubit>(context)
                          .fetchAllDelivery();
                    } else if (deleteState is DeleteDeliveryFail) {
                      showToastMessage(
                          'Failed to delete delivery: ${deleteState.error}');
                    }
                  },
                );
              } else {
                return const SizedBox(); // Handle other states if needed
              }
            },
          ),
        ],
      ),
    );
  }
}
