import 'package:easy_invoice/bloc/delete/TownshipPart/township_delete_cubit.dart';
import 'package:easy_invoice/widget/TownshipPart/AllTownshipsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get/TownshipPart/fetch_all_township_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import 'AddNewTownship.dart';
class Townships extends StatefulWidget {
  const Townships({super.key});

  @override
  State<Townships> createState() => _TownshipsState();
}

class _TownshipsState extends State<Townships> {
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
            'Townships  Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<FetchAllTownshipCubit>(
            create: (context) {
              final cubit = FetchAllTownshipCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.fetchAllTownship();
              return cubit;
            },
          ),
          BlocProvider<TownshipDeleteCubit>(
            create: (context) => TownshipDeleteCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const TownshipScreen()));
  }
}

class TownshipScreen extends StatefulWidget {
  const TownshipScreen({super.key});

  @override
  State<TownshipScreen> createState() => _TownshipScreenState();
}

class _TownshipScreenState extends State<TownshipScreen> {
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
                    builder: (context) => const AddNewTownship(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<FetchAllTownshipCubit>(context).fetchAllTownship();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New Township',
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
          BlocBuilder<FetchAllTownshipCubit, FetchAllTownshipState>(
            builder: (context, state) {
              if (state is FetchAllTownshipLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllTownshipSuccess) {
                final township = state.township;

                if (township.isEmpty) {
                  return const Center(
                    child: Text("No Township found."),
                  );
                }

                return BlocConsumer<TownshipDeleteCubit, TownshipDeleteState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteTownshipLoading;

                    return TownshipWidget(
                      isLoading: loading,
                    );
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteTownshipSuccess) {
                      showToastMessage('Deleted Township successful.');
                      BlocProvider.of<FetchAllTownshipCubit>(context)
                          .fetchAllTownship();
                    } else if (deleteState is DeleteTownshipFail) {
                      showToastMessage(
                          'Failed to delete township: ${deleteState.error}');
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
