import 'package:easy_invoice/bloc/delete/CountryPart/delete_country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/CountryPart/request_country_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CountryPart/CountryWidget.dart';
import 'AddNewCountryScreen.dart';

class Country extends StatefulWidget {
  const Country({super.key});

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Country Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<RequestCountryCubit>(
            create: (context) {
              final cubit = RequestCountryCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.country();
              return cubit;
            },
          ),
          BlocProvider<DeleteCountryCubit>(
            create: (context) => DeleteCountryCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const CountryScreen()));
  }
}

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<Country> country = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddNewCountryScreen(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<RequestCountryCubit>(context).country();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New Country',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<RequestCountryCubit, RequestCountryState>(
            builder: (context, state) {
              if (state is RequestCountryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RequestCountrySuccess) {
                final country = state.country;

                if (country.isEmpty) {
                  return const Center(
                    child: Text("No Country found."),
                  );
                }

                return BlocConsumer<DeleteCountryCubit, DeleteCountryState>(
                  builder: (context, state) {
                    final bool loading = state is DeleteCountryLoading;

                    return CountryWidget(
                      isLoading: loading,
                    );
                  },
                  listener: (context, state) {
                    if (state is DeleteCountryLoading) {
                    } else if (state is DeleteCountrySuccess) {
                      showToastMessage('Deleted Country successful.');
                      context.read<RequestCountryCubit>().country();
                    } else if (state is DeleteCountryFail) {
                      showToastMessage(
                          'Failed to delete country item: ${state.error}');
                    }
                  },
                );
              } else {
                return const SizedBox(); // Handle other states if needed
              }
            },
          ),
        ],
      ),
    );
  }
}
