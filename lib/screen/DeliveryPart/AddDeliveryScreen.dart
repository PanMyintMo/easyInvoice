import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/DeliveryPart/add_delivery_cubit.dart';
import '../../module/module.dart';
import '../../widget/DeliveryPart/AddDeliveryWidget.dart';

class AddDeliveryScreen extends StatelessWidget {
  const AddDeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDeliveryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
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
        body:  BlocBuilder<AddDeliveryCubit, AddDeliveryState>(
          builder: (context, state) {
            if (state is AddDeliveryLoading) {
              return const AddDeliveryWidget(

              );
            } else if (state is AddDeliverySuccess) {
              return AddDeliveryWidget(

              );
            } else if (state is AddDeliveryFail) {
              return AddDeliveryWidget(

              );
            }
            return const AddDeliveryWidget();
          },
        ), // Remove the const from here
      ),
    );
  }
}
