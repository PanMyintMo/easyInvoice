import 'package:easy_invoice/widget/DeliveryPart/RequestDeliveryCompanyInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post/DeliveryPart/add_delivery_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class RequestDeliveryCompanyScreen extends StatelessWidget {
  const RequestDeliveryCompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(
          color: Colors.blue, // Set the color of the navigation icon to black
        ),
        title: const Text(
          'Add Delivery',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AddDeliveryCubit>(
            create: (context) => AddDeliveryCubit(getIt.call()),
          ),
        ],
        child: const Delivery(),
      ),
    );
  }
}

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<AddDeliveryCubit, AddDeliveryState>(
          builder: (context, state) {
            // Section 1: Add Delivery
            bool isLoading = state is AddDeliveryLoading;

            return RequestDeliveryCompanyWidget(
              isLoading: isLoading,
            );
          },
          listener: (context, state) {
            if (state is AddDeliverySuccess) {
              showToastMessage('Add Delivery successful.');
              // Perform any necessary actions after successful delivery addition
            } else if (state is AddDeliveryFail) {
              showToastMessage('Failed to add delivery: ${state.error}');
            }
          },
        ),

      ],
    );
  }
}
