import 'package:easy_invoice/bloc/delete/delete_size_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_size_cubit.dart';
import 'package:easy_invoice/bloc/get/get_all_size_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/widget/AllSizePageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/ToastMessage.dart';

class AllSizesScreen extends StatelessWidget {
  const AllSizesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllSizeCubit>(
          create: (context) {
            final cubit = GetAllSizeCubit(getIt.call()); // Use getIt<ApiService>() to get the ApiService instance
            cubit.getAllSizes(); // call category detail
            return cubit;
          },
        ),
        BlocProvider<DeleteSizeCubit>(
          create: (context) => DeleteSizeCubit(getIt.call()), // Use getIt<ApiService>() to get the ApiService instance
        ),
        BlocProvider<EditSizeCubit>(
          create: (context) => EditSizeCubit(getIt.call()), // Use getIt<ApiService>() to get the ApiService instance
        ),
      ],
      child: Scaffold(
        body: BlocConsumer<GetAllSizeCubit, GetAllSizeState>(
          listener: (context, state) {
            if (state is GetAllSizeFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is GetAllSizeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetAllSizeSuccess) {
              return BlocConsumer<DeleteSizeCubit, DeleteSizeState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteSizeLoading) {
                    // Handle delete category loading state
                  } else if (deleteState is DeleteSizeSuccess) {
                    showToastMessage('Size deleted successfully');
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<GetAllSizeCubit>()
                          .getAllSizes();
                    });
                  } else if (deleteState is DeleteSizeFail) {
                    showToastMessage(
                        'Failed to delete size: ${deleteState.error}');
                  }
                },
                builder: (context, deleteState) {
                  final bool loading = deleteState is DeleteSizeLoading;
                  final String message = deleteState is DeleteSizeFail
                      ? deleteState.error
                      : '';

                  return AllSizePageWidget(
                    sizes: state.getAllSize,
                    isLoading: loading,
                    message: message,
                  );
                },
              );
            } else if (state is GetAllSizeFail) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return const AllSizePageWidget(
              sizes: [],
              isLoading: false,
              message: '',
            );
          },
        ),
      ),
    );
  }

}
