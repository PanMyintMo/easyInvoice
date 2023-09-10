import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_category_cubit.dart';
import 'package:easy_invoice/bloc/get/CategoryPart/get_category_detail_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/ToastMessage.dart';
import '../widget/AllCategoryPageWidget.dart';


class AllCategoryDetailPage extends StatelessWidget {
  const AllCategoryDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetCategoryDetailCubit>(
          create: (context) {
            final cubit = GetCategoryDetailCubit(getIt.call()); // Use getIt<ApiService>() to get the ApiService instance
            cubit.getCategoryDetail(); // call category detail
            return cubit;
          },
        ),
        BlocProvider<DeleteCategoryCubit>(
          create: (context) => DeleteCategoryCubit(getIt.call()), // Use getIt<ApiService>() to get the ApiService instance
        ),
        BlocProvider<EditCategoryCubit>(
          create: (context) => EditCategoryCubit(getIt.call()), // Use getIt<ApiService>() to get the ApiService instance
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'All Category',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),


        body: BlocConsumer<GetCategoryDetailCubit, GetCategoryDetailState>(
          listener: (context, state) {
            if (state is GetCategoryDetailFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is GetCategoryDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetCategoryDetailSuccess) {
              return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteCategoryLoading) {
                    // Handle delete category loading state
                  } else if (deleteState is DeleteCategorySuccess) {
                    showToastMessage('Deleted category successful.');
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<GetCategoryDetailCubit>()
                          .getCategoryDetail();
                    });
                  } else if (deleteState is DeleteCategoryFail) {
                    showToastMessage(
                        'Failed to delete category: ${deleteState.error}');
                  }
                },
                builder: (context, deleteState) {
                  final bool loading = deleteState is DeleteCategoryLoading;
                  final String message = deleteState is DeleteCategoryFail
                      ? deleteState.error
                      : '';

                  return AllCategoryPageWidget(
                    categories: state.getAllCategoryDetail,
                    isLoading: loading,
                    message: message,
                  );
                },
              );
            } else if (state is GetCategoryDetailFail) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return const AllCategoryPageWidget(
              categories: [],
              isLoading: false,
              message: '',
            );
          },
        ),
      ),
    );
  }
}
