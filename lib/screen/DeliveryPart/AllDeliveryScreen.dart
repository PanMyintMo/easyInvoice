import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/delete/DeliveryPart/delete_delivery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get/DeliveryManPart/fetch_all_delivery_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/DeliveryPart/FetchAllDeliveryWidget.dart';
import 'RequestDeliveryCompanyScreen.dart';

class AllDeliveryScreen extends StatelessWidget {
  const AllDeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text(
          'All Delivery  Screen',
          style: TextStyle(
              color:AdaptiveTheme.of(context).theme.iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FetchAllDeliveryCubit>(
            create: (context) {
              final cubit = FetchAllDeliveryCubit(getIt.call());
              cubit.fetchAllDelivery();
              return cubit;
            },
          ),
          BlocProvider<DeleteDeliveryCubit>(
            create: (context) => DeleteDeliveryCubit(getIt.call()),
          ),
        ],
        child: const DeliveryScreen(),
      ),
    );
  }
}

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RequestDeliveryCompanyScreen(),
                ),
              );
              if (result == true) {
                BlocProvider.of<FetchAllDeliveryCubit>(context)
                    .fetchAllDelivery();
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
        Expanded(
          flex: 1,
          child: BlocBuilder<FetchAllDeliveryCubit, FetchAllDeliveryState>(
            builder: (context, state) {
              if (state is FetchAllDeliveryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllDeliverySuccess) {
                final deliveryItem = state.deliveryItemData;

                if (deliveryItem.isEmpty) {
                  return const Center(
                    child: Text("No Data found."),
                  );
                }

                return BlocConsumer<DeleteDeliveryCubit, DeleteDeliveryState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteDeliveryLoading;

                    return FetchAllDeliveryWidget(
                      isLoading: loading,
                      deliveriesItem:state.deliveryItemData,
                    );
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteDeliverySuccess) {
                      showToastMessage('Deleted Delivery successful.');
                      BlocProvider.of<FetchAllDeliveryCubit>(context)
                          .fetchAllDelivery();
                    } else if (deleteState is DeleteDeliveryFail) {
                      showToastMessage(
                        'Failed to delete delivery: ${deleteState.error}',
                      );
                    }
                  },
                );
              } else {
                return const SizedBox(); // Handle other states if needed
              }
            },
          ),
        ),
      ],
    );
  }
}
