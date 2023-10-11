import 'package:easy_invoice/bloc/post/DeliveryPart/update_delivery_cubit.dart';
import 'package:easy_invoice/widget/DeliveryPart/UpdateDeliveryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/DeliveryPart/deli_company_info_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class UpdateDelivery extends StatefulWidget {
  final int id;
  final String city_id;
  final String township_id;
  final String basic_cost;
  final String waiting_time;
  final String company_id;
  const UpdateDelivery({super.key, required this.id, required this.city_id, required this.township_id, required this.basic_cost, required this.waiting_time, required this.company_id});

  @override
  State<UpdateDelivery> createState() => _UpdateDeliveryState();
}

class _UpdateDeliveryState extends State<UpdateDelivery> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateDeliveryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text('Update Delivery',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
        body: BlocBuilder<UpdateDeliveryCubit, UpdateDeliveryState>(
          builder: (context, state) {
            final loading = state is UpdateDeliveryLoading;
            if (state is DeliCompanyInfoLoading) {
              return const CircularProgressIndicator();
            } else if (state is UpdateDeliverySuccess) {
              showToastMessage("Successful");
              Navigator.pop(context, true);
              return  UpdateDeliveryWidget(
                isLoading: loading, id: widget.id, city_id: widget.city_id, township_id: widget.township_id, waiting_time: widget.waiting_time, basic_cost: widget.basic_cost, company_id: widget.company_id,
              );
            } else if (state is UpdateDeliveryFail) {
              showToastMessage(state.error);
              return  UpdateDeliveryWidget(
                isLoading: loading, id: widget.id, city_id: widget.city_id, township_id: widget.township_id, waiting_time: widget.waiting_time, basic_cost: widget.basic_cost, company_id: widget.company_id,
              );
            }
            return  UpdateDeliveryWidget(
              isLoading: loading, id: widget.id, city_id: widget.city_id, township_id: widget.township_id, waiting_time: widget.waiting_time, basic_cost: widget.basic_cost, company_id: widget.company_id,
            );
          },
        ),
      ),
    );
  }
}
