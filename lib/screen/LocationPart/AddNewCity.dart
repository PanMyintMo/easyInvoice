import 'package:easy_invoice/bloc/post/CityPart/add_city_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/AddNewCityWidget.dart';

class AddNewCity extends StatefulWidget {
  const AddNewCity({super.key});

  @override
  State<AddNewCity> createState() => _AddNewCityState();
}

class _AddNewCityState extends State<AddNewCity> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCityCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Add New City',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<AddCityCubit, AddCityState>(
          builder: (context, state) {
            if (state is AddCityLoading) {
              return const AddNewCityWidget(isLoading : true);
            } else if (state is AddCitySuccess) {
              showToastMessage(state.cityResponse.message);
              Navigator.pop(context,true);
              return const AddNewCityWidget(isLoading : false);
            } else if (state is AddCityFail) {
              showToastMessage(state.error.toString());
              return const AddNewCityWidget(isLoading : false);
            }
            return const AddNewCityWidget(isLoading : false);
          },
        ), // Remove the const from here
      ),
    );
  }
}
