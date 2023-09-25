import 'package:easy_invoice/widget/DeliveryPart/UpdateDeliveryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/DeliveryPart/deli_company_info_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/DeliveryPart/AddDeliveryWidget.dart';
class UpdateDelivery extends StatefulWidget {
  const UpdateDelivery({super.key});

  @override
  State<UpdateDelivery> createState() => _UpdateDeliveryState();
}

class _UpdateDeliveryState extends State<UpdateDelivery> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliCompanyInfoCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
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
              return UpdateDeliveryWidget(isLoading: loading);
            } else if (state is DeliCompanyInfoSuccess) {
              showToastMessage("Successful");
              Navigator.pop(context, true);
              return const UpdateDeliveryWidget(
                isLoading: false,
              );
            } else if (state is DeliCompanyInfoFail) {
              showToastMessage(state.error);
              return const UpdateDeliveryWidget(
                isLoading: false,
              );
            }
            return const UpdateDeliveryWidget(
              isLoading: false,
            );
          },
        ),
      ),
    );
  }
}
