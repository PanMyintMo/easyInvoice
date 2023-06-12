import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_category_cubit.dart';
import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/AllCategoryPageWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AllCategoryDetailPage extends StatelessWidget {
  const AllCategoryDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetCategoryDetailCubit>(
          create: (context) {
            final cubit = GetCategoryDetailCubit(getIt.call());
            cubit.getCategoryDetail(); // call category detail
            return cubit;
          },
        ),
        BlocProvider<DeleteCategoryCubit>(
          create: (context) => DeleteCategoryCubit(getIt.call()),
        ),
        BlocProvider<EditCategoryCubit>(
            create: (context) => EditCategoryCubit(getIt.call()))
      ],
      child: Scaffold(
        body: BlocBuilder<GetCategoryDetailCubit, GetCategoryDetailState>(
          builder: (context, state) {
            if (state is GetCategoryDetailLoading) {
              return const Center(child: Text('Loading'));
            } else if (state is GetCategoryDetailSuccess) {
              return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteCategoryLoading) {
                    // Show loading indicator while deleting
                    const Center(child: CircularProgressIndicator());
                  } else if (deleteState is DeleteCategorySuccess) {
                    // Show success toast message after successful deletion
                    showSuccessToast('Category deleted successfully');
                    // Reload category details to update the UI
                    BlocProvider.of<GetCategoryDetailCubit>(context)
                        .getCategoryDetail();
                  } else if (deleteState is DeleteCategoryFail) {
                    // Show error toast message after deletion failure
                    showErrorToast(
                        'Failed to delete category ${deleteState.error}');
                  }
                },
                builder: (context, deleteState) {
                  if (deleteState is DeleteCategoryLoading) {
                    // Show loading indicator while deleting
                    return const Center(child: CircularProgressIndicator());
                  } else if (deleteState is DeleteCategorySuccess) {
                    return AllCategoryPageWidget(
                        categories: state.getAllCategoryDetail);
                  } else if (deleteState is DeleteCategoryFail) {
                    return AllCategoryPageWidget(
                        categories: state.getAllCategoryDetail);
                  }
                  return AllCategoryPageWidget(
                      categories: state.getAllCategoryDetail);
                },
              );
            } else if (state is GetCategoryDetailFail) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const AllCategoryPageWidget(categories: []);
          },
        ),
      ),
    );
  }
}

void showErrorToast(String error) {
  Fluttertoast.showToast(
    msg: "Category delete failed !",
    toastLength: Toast.LENGTH_SHORT,
    // Duration for which the toast should be visible
    gravity: ToastGravity.BOTTOM,
    // Position where the toast should appear on the screen
    backgroundColor: Colors.black54,
    // Background color of the toast
    textColor: Colors.white, // Text color of the toast message
  );
}

void showSuccessToast(String success) {
  Fluttertoast.showToast(
    msg: "Category delete successfully message!",
    toastLength: Toast.LENGTH_SHORT,
    // Duration for which the toast should be visible
    gravity: ToastGravity.BOTTOM,
    // Position where the toast should appear on the screen
    backgroundColor: Colors.black54,
    // Background color of the toast
    textColor: Colors.white, // Text color of the toast message
  );
}
