import 'package:easy_invoice/bloc/delete/CityPart/delete_street_cubit.dart';
import 'package:easy_invoice/screen/LocationPart/AddStreetScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get/CityPart/fetch_all_street_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/StreetWidget.dart';

class StreetScreen extends StatelessWidget {
  const StreetScreen({Key? key}) : super(key: key);

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
          'Street Screen',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FetchAllStreetCubit>(
            create: (context) {
              final cubit = FetchAllStreetCubit(getIt.call());
              cubit.fetchAllStreet();
              return cubit;
            },
          ),
          BlocProvider<DeleteStreetCubit>(
            create: (context) => DeleteStreetCubit(getIt.call()),
          ),
        ],
        child: const Street(),
      ),
    );
  }
}

class Street extends StatelessWidget {
  const Street({Key? key}) : super(key: key);

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
                    builder: (context) => const AddStreetScreen(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<FetchAllStreetCubit>(context).fetchAllStreet();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New Street',
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
          BlocBuilder<FetchAllStreetCubit, FetchAllStreetState>(
            builder: (context, state) {
              if (state is FetchAllStreetLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllStreetSuccess) {
                final street = state.street;

                if (street.isEmpty) {
                  return const Center(
                    child: Text("No Streets found."),
                  );
                }

                return BlocConsumer<DeleteStreetCubit, DeleteStreetState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteStreetLoading;

                    return StreetWidget(
                      isLoading: loading,
                      street: street, // Pass the street data here
                    );
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteStreetSuccess) {
                      showToastMessage('Deleted Street successful.');
                      BlocProvider.of<FetchAllStreetCubit>(context)
                          .fetchAllStreet();
                    } else if (deleteState is DeleteStreetFail) {
                      showToastMessage(
                          'Failed to delete street: ${deleteState.error}');
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
