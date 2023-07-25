import 'package:easy_invoice/bloc/get/fetch_all_city_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/CitiesWidget.dart';

class Cities extends StatefulWidget {
  const Cities({super.key});

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllCityCubit(getIt.call()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Cities Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<FetchAllCityCubit, FetchAllCityState>(
          builder: (context, state) {
            if (state is FetchAllCityLoading ) {
              return const CitiesWidget(isLoading: true);
            }
            else if (state is  FetchAllCitySuccess) {
              showToastMessage('Success');
              return const CitiesWidget(isLoading: false);
            }
            else if (state is FetchAllCityFail) {
              showToastMessage('Failed');
              return const CitiesWidget(isLoading: false);
            } else {
              // Initial state or unknown state
              return const CitiesWidget(isLoading: false);
            }
          },
        ),
      ),
    );
  }
}
