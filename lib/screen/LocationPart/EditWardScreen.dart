import 'package:easy_invoice/bloc/edit/CityPart/edit_ward_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/edit/CityPart/edit_city_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/EditWardWidget.dart';

class EditWardScreen extends StatelessWidget {
  final String state_id;
  final String ward_name;


  const EditWardScreen(
      {super.key,
      required this.state_id,
      required this.ward_name,
     });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditWardCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Edit Ward Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<EditWardCubit, EditWardState>(
          builder: (context, state) {
            if (state is EditWardLoading) {
              return EditWardWidget(
                ward_name: ward_name,
                isLoading: true,
                state_id: state_id,
              );
            } else if (state is EditCitySuccess) {
              showToastMessage("Ward updated successfully.");
              Navigator.pop(context, true);
            } else if (state is EditCityFail) {
              showToastMessage("Ward updated fail.");
              return EditWardWidget(
                ward_name: ward_name,
                isLoading: false,
                state_id: state_id,

              );
            }

            return EditWardWidget(
              ward_name: ward_name,
              isLoading: false,
              state_id: state_id,

            );
          },
        ),
      ),
    );
  }
}
