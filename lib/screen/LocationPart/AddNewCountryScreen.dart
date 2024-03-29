import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/post/CountryPart/add_request_country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CountryPart/AddNewCountryWidget.dart';

class AddNewCountryScreen extends StatelessWidget {
  const AddNewCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddRequestCountryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            'Add New Country',
            style: TextStyle(
              color:AdaptiveTheme.of(context).theme.iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        body: BlocBuilder<AddRequestCountryCubit, AddRequestCountryState>(
          builder: (context, state) {
            if (state is AddRequestCountryLoading) {
              return const AddNewCountry(isLoading : true);
            } else if (state is AddRequestCountrySuccess) {
              showToastMessage(state.requestCountryResponse.message);
              Navigator.pop(
                  context,true);
              return const AddNewCountry(isLoading : false);
            } else if (state is AddRequestCountryFail) {
              showToastMessage(state.error);
              return const AddNewCountry(isLoading : false);
            }
            return const AddNewCountry(isLoading : false);
          },
        ), // Remove the const from here
      ),
    );
  }
}
