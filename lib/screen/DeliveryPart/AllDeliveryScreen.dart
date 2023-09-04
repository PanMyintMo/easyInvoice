import 'package:easy_invoice/bloc/delete/DeliveryPart/delete_delivery_cubit.dart';
import 'package:easy_invoice/bloc/get/DeliveryManPart/fetch_all_delivery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/DeliveryPart/FetchAllDeliveryWidget.dart';

class AllDeliveryScreen extends StatefulWidget {
  const AllDeliveryScreen({super.key});

  @override
  State<AllDeliveryScreen> createState() => _AllDeliveryScreenState();
}

class _AllDeliveryScreenState extends State<AllDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchAllDeliveryCubit>(
          create: (context) {
            final cubit = FetchAllDeliveryCubit(
              getIt.call(),
            );
            cubit.fetchAllDelivery();
            return cubit;
          },
        ),
        BlocProvider<DeleteDeliveryCubit>(
          create: (context) => DeleteDeliveryCubit(
            getIt.call(),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red,
          ),
          title: const Text(
            'All Delivery Screen',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocConsumer<FetchAllDeliveryCubit, FetchAllDeliveryState>(
          listener: (context, state) {
            if (state is FetchAllDeliveryFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is FetchAllDeliveryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllDeliverySuccess) {
              return BlocConsumer<DeleteDeliveryCubit, DeleteDeliveryState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteDeliveryLoading) {

                  } else if (deleteState is DeleteDeliverySuccess) {
                    showToastMessage(deleteState.deleteResponse.message);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<FetchAllDeliveryCubit>().fetchAllDelivery();
                    });
                  } else if (deleteState is DeleteDeliveryFail) {
                    showToastMessage(deleteState.error);
                  }
                },
                builder: (context, deleteState) {
                  return FetchAllDeliveryWidget(
                    deliveriesItem: state.deliveryItemData,
                  );
                },
              );
            } else if (state is FetchAllDeliveryFail) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const SizedBox(); // Return an empty SizedBox if none of the states match
          },
        ),
      ),
    );
  }
}
