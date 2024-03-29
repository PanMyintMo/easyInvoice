import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/post/CityPart/add_ward_cubit.dart';
import 'package:easy_invoice/widget/CityPart/AddWardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';

class AddWardScreen extends StatelessWidget {
  const AddWardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWardCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(

          title:  Text(
            'Add Ward Screen',
            style: TextStyle(
              color:AdaptiveTheme.of(context).theme.iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<AddWardCubit, AddWardState>(
          builder: (context, state) {
            if (state is AddWardLoading) {
              return const AddWardWidget(isLoading : true);
            } else if (state is AddWardSuccess) {
              showToastMessage(state.addWardResponse.message);
              Navigator.pop(context,true);
              return const AddWardWidget(isLoading : false);
            } else if (state is AddWardFail) {
              showToastMessage(state.error.toString());
              return const AddWardWidget(isLoading : false);
            }
            return const AddWardWidget(isLoading : false);
          },
        ), // Remove the const from here
      ),
    );
  }
}
