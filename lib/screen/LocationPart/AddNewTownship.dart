import 'package:adaptive_theme/adaptive_theme.dart';
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
          iconTheme:  IconThemeData(
            color:AdaptiveTheme.of(context).theme.iconTheme.color, // Set the color of the navigation icon to black
          ),
          title:Text(
            'Add New Township',
            style: TextStyle(
              color: AdaptiveTheme.of(context).theme.iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<AddTownshipCubit, AddTownshipState>(
          builder: (context, state) {
            final isLoading=state is AddTownshipLoading;
            if (state is AddTownshipLoading) {
              return  AddNewTownshipWidget(isLoading : isLoading);
            } else if (state is AddTownshipSuccess) {
              showToastMessage(state.townshipResponse.message);
              Navigator.pop(context,true);
              return  AddNewTownshipWidget(isLoading : isLoading);
            } else if (state is AddTownshipFail) {
              showToastMessage(state.error.toString());
              return  AddNewTownshipWidget(isLoading : isLoading);
            }
            return  AddNewTownshipWidget(isLoading : isLoading);
          },
        ), // Remove the const from here
      ),
    );
  }
}
