import 'package:easy_invoice/bloc/post/DeliveryPart/add_delivery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../module/module.dart';
import '../../widget/DeliveryPart/AddDeliveryWidget.dart';


class AddDeliveryScreen extends StatefulWidget {
  const AddDeliveryScreen({super.key});

  @override
  State<AddDeliveryScreen> createState() => _AddDeliveryScreenState();
}

class _AddDeliveryScreenState extends State<AddDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDeliveryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ), title: const Text('Add Delivery', style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16)),),
        body: BlocBuilder<AddDeliveryCubit, AddDeliveryState>(
          builder: (context, state) {
            if (state is AddDeliveryLoading) {}
            else if (state is AddDeliverySuccess) {}
            else {}

            return const AddDeliveryWidget();
          },
        ),

      ),
    );
  }
}
