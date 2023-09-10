import 'package:easy_invoice/bloc/post/TownshipPart/add_township_cubit.dart';
import 'package:easy_invoice/widget/TownshipPart/AddNewTownshipWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class AddNewTownship extends StatefulWidget {
  const AddNewTownship({super.key});

  @override
  State<AddNewTownship> createState() => _AddNewTownshipState();
}

class _AddNewTownshipState extends State<AddNewTownship> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTownshipCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Add New Township',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<AddTownshipCubit, AddTownshipState>(
          builder: (context, state) {
            if (state is AddTownshipLoading) {
              return const AddNewTownshipWidget(isLoading : true);
            } else if (state is AddTownshipSuccess) {
              showToastMessage(state.townshipResponse.message);
              Navigator.pop(context,true);
              return const AddNewTownshipWidget(isLoading : false);
            } else if (state is AddTownshipFail) {
              showToastMessage(state.error.toString());
              return const AddNewTownshipWidget(isLoading : false);
            }
            return const AddNewTownshipWidget(isLoading : false);
          },
        ), // Remove the const from here
      ),
    );
  }
}
