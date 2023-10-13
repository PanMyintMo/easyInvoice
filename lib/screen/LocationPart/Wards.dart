import 'package:easy_invoice/bloc/delete/CityPart/delete_ward_cubit.dart';
import 'package:easy_invoice/bloc/get/CityPart/fetch_all_ward_cubit.dart';
import 'package:easy_invoice/screen/LocationPart/AddWardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/WardsWidget.dart';

class Wards extends StatelessWidget {
  const Wards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.blue, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Ward Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<FetchAllWardCubit>(
            create: (context) {
              final cubit = FetchAllWardCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.fetchAllWard();
              return cubit;
            },
          ),
          BlocProvider<DeleteWardCubit>(
            create: (context) => DeleteWardCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const WardScreen()));
  }
}

class WardScreen extends StatelessWidget {
  const WardScreen({super.key});

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
                    builder: (context) => const AddWardScreen(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<FetchAllWardCubit>(context).fetchAllWard();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New Ward',
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
          BlocBuilder<FetchAllWardCubit, FetchAllWardState>(
            builder: (context, state) {
              if (state is FetchAllWardLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllWardSuccess) {
                final ward = state.ward;

                if (ward.isEmpty) {
                  return const Center(
                    child: Text("No Wards found."),
                  );
                }

                return BlocConsumer<DeleteWardCubit, DeleteWardState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteWardLoading;

                    return WardsWidget(
                      isLoading: loading, ward: state.ward,
                    );
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteWardSuccess) {
                      showToastMessage('Deleted Ward successful.');
                      BlocProvider.of<FetchAllWardCubit>(context)
                          .fetchAllWard();
                    } else if (deleteState is DeleteWardFail) {
                      showToastMessage(
                          'Failed to delete ward: ${deleteState.error}');
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
