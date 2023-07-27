import 'package:easy_invoice/bloc/edit/TownshipPart/edit_township_cubit.dart';
import 'package:easy_invoice/widget/TownshipPart/EditTownshipWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';
class EditTownshipScreen extends StatefulWidget {
  final String city_id;
  final String name;
  final int id;
  const EditTownshipScreen({super.key, required this.city_id, required this.name, required this.id});

  @override
  State<EditTownshipScreen> createState() => _EditTownshipScreenState();
}

class _EditTownshipScreenState extends State<EditTownshipScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTownshipCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Edit Township Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<EditTownshipCubit, EditTownshipState>(
          builder: (context, state) {
            if (state is EditTownshipLoading) {
              return EditTownshipWidget(
                name: widget.name,
                id: widget.id,
                isLoading: true,
              city_id: widget.city_id,
              );
            } else if (state is EditTownshipSuccess) {
              showToastMessage("City updated successfully.");
              // Navigate back to the GetAllCategoryScreen and trigger a refresh
              Navigator.pop(
                  context,
                  EditTownshipWidget(
                    name: widget.name,
                    isLoading: false,
                    city_id: widget.city_id, id: widget.id,
                  ));
            } else if (state is EditTownshipFail) {
              showToastMessage("City updated fail.");
              return EditTownshipWidget(
                name: widget.name,
                isLoading: false,
                city_id: widget.city_id, id: widget.id,
              );
            }

            return EditTownshipWidget(
              name: widget.name,
              isLoading: false,
              city_id: widget.city_id, id: widget.id,
            );
          },
        ),
      ),
    );
  }
}
