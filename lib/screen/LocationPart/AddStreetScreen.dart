import 'package:easy_invoice/widget/CityPart/AddStreetWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/CityPart/add_street_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
class AddStreetScreen extends StatefulWidget {
  const AddStreetScreen({super.key});

  @override
  State<AddStreetScreen> createState() => _AddStreetScreenState();
}

class _AddStreetScreenState extends State<AddStreetScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStreetCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Add Street Screen',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<AddStreetCubit, AddStreetState>(
          builder: (context, state) {
            if (state is AddStreetLoading) {
              return const AddStreetWidget(isLoading : true);
            } else if (state is AddStreetSuccess) {
              showToastMessage(state.addStreetResponse.message);
              Navigator.pop(context,true);
              return const AddStreetWidget(isLoading : false);
            } else if (state is AddStreetFail) {
              showToastMessage(state.error.toString());
              return const AddStreetWidget(isLoading : false);
            }
            return const AddStreetWidget(isLoading : false);
          },
        ), // Remove the const from here
      ),
    );
  }
}
