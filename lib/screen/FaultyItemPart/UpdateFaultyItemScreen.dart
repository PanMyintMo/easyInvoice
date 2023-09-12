import 'package:easy_invoice/widget/FaultyItemPart/UpdateFaultyWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit/FaultyPart/update_faulty_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class UpdateFaultyItemScreen extends StatefulWidget {
  final int quantity;
  final int id;
  final int category_id;
  final int product_id;

  const UpdateFaultyItemScreen({super.key, required this.quantity, required this.id, required this.category_id, required this.product_id});

  @override
  State<UpdateFaultyItemScreen> createState() => _UpdateFaultyItemScreenState();
}

class _UpdateFaultyItemScreenState extends State<UpdateFaultyItemScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateFaultyCubit(getIt.call()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Update Faulty Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<UpdateFaultyCubit, UpdateFaultyState>(
          builder: (context, state) {
            if (state is UpdateFaultyLoading ) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is  UpdateFaultySuccess) {
              showToastMessage(state.response.message.toString());
              return  UpdateFaultyWidget( quantity: widget.quantity, id:widget.id, category_id: widget.category_id.toString(), product_id: widget.product_id.toString(), );
            }
            else if (state is UpdateFaultyFail) {
              showToastMessage(state.error);
              return  UpdateFaultyWidget( quantity: widget.quantity, id: widget.id, category_id: widget.category_id.toString(), product_id: widget.product_id.toString());
            }
            return  UpdateFaultyWidget(quantity: widget.quantity,id: widget.id, category_id: widget.category_id.toString(), product_id: widget.product_id.toString(),);
          },
        ),
      ),
    );
  }
}
