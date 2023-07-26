import 'package:easy_invoice/bloc/get/fetch_all_city_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/delete/CityPart/delete_city_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/CitiesWidget.dart';

class Cities extends StatefulWidget {
  const Cities({super.key});

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchAllCityCubit>(
          create: (context) {
            final cubit = FetchAllCityCubit(getIt
                .call()); // Use getIt<ApiService>() to get the ApiService instance
            cubit.fetchAllCity();
            return cubit;
          },
        ),
        BlocProvider<DeleteCityCubit>(
          create: (context) => DeleteCityCubit(getIt
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
            'City Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocConsumer<FetchAllCityCubit, FetchAllCityState>(
          listener: (context, state) {
            if (state is FetchAllCityFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is FetchAllCityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllCitySuccess) {
              return BlocConsumer<DeleteCityCubit, DeleteCityState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteCityLoading) {

                  } else if (deleteState is DeleteCitySuccess) {
                    showToastMessage(deleteState.deleteCityResponse.message);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<FetchAllCityCubit>().fetchAllCity();
                    });
                  } else if (deleteState is DeleteCityFail) {
                    showToastMessage(deleteState.error);

                  }
                },
                builder: (context, deleteState) {
                  final bool loading = deleteState is DeleteCityLoading;
                  return CitiesWidget(
                    isLoading: loading,
                  );
                },
              );
            } else if (state is FetchAllCityFail) {
              const CitiesWidget(
                isLoading: false,
              );
              return Center(child: Text('Error: ${state.error}'));
            }

            return const CitiesWidget(
              isLoading: false,
            );
          },
        ),
      ),
    );
  }
}
