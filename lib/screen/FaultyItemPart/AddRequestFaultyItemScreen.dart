import 'package:easy_invoice/bloc/post/FaultyItemPart/add_request_faulty_item_cubit.dart';
import 'package:easy_invoice/widget/FaultyItemPart/AddRequestFaultyItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import 'FaultyItems.dart';

class AddRequestFaultyItem extends StatefulWidget {
  const AddRequestFaultyItem({Key? key}) : super(key: key);

  @override
  State<AddRequestFaultyItem> createState() => _AddRequestFaultyItemState();
}

class _AddRequestFaultyItemState extends State<AddRequestFaultyItem> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddRequestFaultyItemCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Add Faulty Item Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<AddRequestFaultyItemCubit, AddRequestFaultyItemState>(
          builder: (context, state) {
            if (state is AddRequestFaultyItemLoading) {
              return const AddRequestFaultyItemWidget(
                isLoading: true,
              );
            } else if (state is AddRequestFaultyItemSuccess) {
              showToastMessage(state.addFaultyItemResponse.message);
              Navigator.pop(
                  context,true);
            } else if (state is AddRequestFaultyItemFail) {
              showToastMessage(state.error);
              return const AddRequestFaultyItemWidget(
                isLoading: false,
              );
            }

            return const AddRequestFaultyItemWidget(
              isLoading: false,
            );
          },
        ),
      ),
    );
  }
}
