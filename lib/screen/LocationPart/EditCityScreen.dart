import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit/CityPart/edit_city_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/EditCityWidget.dart';

class EditCityScreen extends StatelessWidget {
  final String country_id;
  final String name;
  final int id;

  const EditCityScreen({super.key, required this.country_id, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCityCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Edit City Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<EditCityCubit, EditCityState>(
          builder: (context, state) {
            if (state is EditCityLoading) {
              return EditCityWidget(
                name: name,
                isLoading: true,
                country_id: country_id, id: id,
              );
            } else if (state is EditCitySuccess) {
              showToastMessage("City updated successfully.");
              // Navigate back to the GetAllCategoryScreen and trigger a refresh
              Navigator.pop(
                  context,
                  EditCityWidget(
                    name: name,
                    isLoading: false,
                    country_id: country_id, id: id,
                  ));
            } else if (state is EditCityFail) {
              showToastMessage("City updated fail.");
              return EditCityWidget(
                name: name,
                isLoading: false,
                country_id: country_id, id: id,
              );
            }

            return EditCityWidget(
              name: name,
              isLoading: false,
              country_id: country_id, id: id,
            );
          },
        ),
      ),
    );

  }
}
