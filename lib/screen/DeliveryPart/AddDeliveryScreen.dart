import 'package:easy_invoice/widget/DeliveryPart/AddDeliveryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post/DeliveryPart/deli_company_info_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class AddDeliveryScreen extends StatefulWidget {
  const AddDeliveryScreen({super.key});

  @override
  State<AddDeliveryScreen> createState() => _AddDeliveryScreenState();
}

class _AddDeliveryScreenState extends State<AddDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliCompanyInfoCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.blue, // Set the color of the navigation icon to black
          ),
          title: const Text('Add Delivery',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
        body: BlocBuilder<DeliCompanyInfoCubit, DeliCompanyInfoState>(
          builder: (context, state) {
            final loading = state is DeliCompanyInfoLoading;
            if (state is DeliCompanyInfoLoading) {
              return AddDeliveryWidget(isLoading: loading);
            } else if (state is DeliCompanyInfoSuccess) {
              showToastMessage("Successful");
              Navigator.pop(context, true);
              return const AddDeliveryWidget(
                isLoading: false,
              );
            } else if (state is DeliCompanyInfoFail) {
              showToastMessage(state.error);
              return const AddDeliveryWidget(
                isLoading: false,
              );
            }
            return const AddDeliveryWidget(
              isLoading: false,
            );
          },
        ),
      ),
    );
  }
}
