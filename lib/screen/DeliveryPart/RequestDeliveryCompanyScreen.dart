import 'package:adaptive_theme/adaptive_theme.dart';
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
      appBar: AppBar(
        iconTheme:  IconThemeData(
          color: AdaptiveTheme.of(context).theme.iconTheme.color, // Set the color of the navigation icon to black
        ),
        title:  Text(
          'Add Delivery',
          style: TextStyle(
            color:AdaptiveTheme.of(context).theme.iconTheme.color,
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
