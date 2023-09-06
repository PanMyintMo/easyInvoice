import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/delete/CountryPart/delete_country_cubit.dart';
import '../../bloc/post/CountryPart/request_country_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CountryPart/CountryWidget.dart';
class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
            'All Order Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body:  BlocConsumer<RequestCountryCubit, RequestCountryState>(
          listener: (context, state) {
            if (state is RequestCountryFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is RequestCountryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RequestCountrySuccess) {
              return BlocConsumer<DeleteCountryCubit, DeleteCountryState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteCountryLoading) {
                    // Handle delete category loading state
                  } else if (deleteState is DeleteCountrySuccess) {
                    showToastMessage(deleteState.deleteCountryResponse.message);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<RequestCountryCubit>()
                          .country();
                    });
                  } else if (deleteState is DeleteCountryFail) {
                    showToastMessage(
                        deleteState.error);
                  }
                },
                builder: (context, deleteState) {
                  final bool loading = deleteState is DeleteCountryLoading;
                  return CountryWidget(
                    isLoading: loading,

                  );
                },
              );
            } else if (state is RequestCountryFail) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return const CountryWidget(

              isLoading: false,

            );
          },
        ),
      ),
    );
  }
}
