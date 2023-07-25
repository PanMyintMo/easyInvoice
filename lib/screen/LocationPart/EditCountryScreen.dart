import 'package:easy_invoice/bloc/edit/CountryPart/edit_country_cubit.dart';
import 'package:easy_invoice/common/ToastMessage.dart';
import 'package:easy_invoice/widget/CountryPart/EditCountryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../module/module.dart';

class EditCountryScreen extends StatefulWidget {
  final int id;
  final String name;

  const EditCountryScreen({super.key, required this.id, required this.name});

  @override
  State<EditCountryScreen> createState() => _EditCountryScreenState();
}

class _EditCountryScreenState extends State<EditCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCountryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Edit Country Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<EditCountryCubit, EditCountryState>(
          builder: (context, state) {
            if (state is EditCountryLoading) {

              return EditCountryWidget(
                  name: widget.name, id: widget.id, isLoading: true);
            } else if (state is EditCountrySuccess) {
              showToastMessage("Country updated successfully.");
              // Navigate back to the GetAllCategoryScreen and trigger a refresh
              Navigator.pop(
                  context,
                  EditCountryWidget(
                      name: widget.name, id: widget.id, isLoading: false));
            } else if (state is EditCountryFail) {
              showToastMessage("Country updated fail.");
              return EditCountryWidget(
                  name: widget.name, id: widget.id, isLoading: false);
            }

            return EditCountryWidget(
                name: widget.name, id: widget.id, isLoading: false);
          },
        ),
      ),
    );
  }
}
