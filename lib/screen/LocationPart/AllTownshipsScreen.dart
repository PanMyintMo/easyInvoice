import 'package:easy_invoice/bloc/delete/TownshipPart/township_delete_cubit.dart';
import 'package:easy_invoice/widget/TownshipPart/AllTownshipsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get/TownshipPart/fetch_all_township_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
class Townships extends StatefulWidget {
  const Townships({super.key});

  @override
  State<Townships> createState() => _TownshipsState();
}

class _TownshipsState extends State<Townships> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Townships Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocConsumer<FetchAllTownshipCubit, FetchAllTownshipState>(
          listener: (context, state) {
            if (state is FetchAllTownshipFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is FetchAllTownshipLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllTownshipSuccess) {
              return BlocConsumer<TownshipDeleteCubit, TownshipDeleteState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteTownshipLoading) {

                  } else if (deleteState is DeleteTownshipSuccess) {
                    showToastMessage(deleteState.deleteTownshipResponse.message);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<FetchAllTownshipCubit>().fetchAllTownship();
                    });
                  } else if (deleteState is DeleteTownshipFail) {
                    showToastMessage(deleteState.error);

                  }
                },
                builder: (context, deleteState) {
                  final bool loading = deleteState is DeleteTownshipLoading;
                  return TownshipWidget(
                    isLoading: loading,
                  );
                },
              );
            } else if (state is FetchAllTownshipFail) {
              const TownshipWidget(
                isLoading: false,
              );
              return Center(child: Text('Error: ${state.error}'));
            }

            return const TownshipWidget(
              isLoading: false,
            );
          },
        ),
      ),
    );
  }
}
