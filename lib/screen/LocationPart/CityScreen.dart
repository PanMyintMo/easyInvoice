import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get/CityPart/fetch_all_city_cubit.dart';
import '../../bloc/delete/CityPart/delete_city_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/CitiesWidget.dart';
import 'AddNewCity.dart';

class Cities extends StatefulWidget {
  const Cities({Key? key}) : super(key: key);

  @override
  _CitiesState createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
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
            'City Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
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
        ], child: const CityScreen()));
  }
}

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
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
                    builder: (context) => const AddNewCity(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<FetchAllCityCubit>(context).fetchAllCity();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New City',
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
          BlocBuilder<FetchAllCityCubit, FetchAllCityState>(
            builder: (context, state) {
              if (state is FetchAllCityLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllCitySuccess) {
                final cityList = state.city;

                if (cityList.isEmpty) {
                  return const Center(
                    child: Text("No Cities found."),
                  );
                }

                return BlocConsumer<DeleteCityCubit, DeleteCityState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteCityLoading;

                    return CitiesWidget(
                      isLoading: loading,cities : state.city
                    );
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteCitySuccess) {
                      showToastMessage('Deleted City successful.');
                      BlocProvider.of<FetchAllCityCubit>(context)
                          .fetchAllCity();
                    } else if (deleteState is DeleteCityFail) {
                      showToastMessage(
                          'Failed to delete city: ${deleteState.error}');
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
