import 'package:easy_invoice/bloc/get/get_all_user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/delete/delete_category_cubit.dart';
import '../bloc/edit/edit_category_cubit.dart';
import '../bloc/get/get_category_detail_cubit.dart';
import '../module/module.dart';
import '../widget/AllUserRoleWidget.dart';

class AllUserRoleScreen extends StatefulWidget {
  const AllUserRoleScreen({Key? key}) : super(key: key);

  @override
  State<AllUserRoleScreen> createState() => _AllUserRoleScreenState();
}

class _AllUserRoleScreenState extends State<AllUserRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[
    BlocProvider<GetAllUserRoleCubit>(
    create: (context) {
      final cubit = GetAllUserRoleCubit(getIt.call()); // Use getIt<ApiService>() to get the ApiService instance
      cubit.getAllUserRole(); // call category detail
      return cubit;
    },
    ),
    BlocProvider<DeleteCategoryCubit>(
    create: (context) => DeleteCategoryCubit(getIt.call()), // Use getIt<ApiService>() to get the ApiService instance
    ),
    BlocProvider<EditCategoryCubit>(
    create: (context) => EditCategoryCubit(getIt.call()), // Use getIt<ApiService>() to get the ApiService instance
    ),
    ], child:  Scaffold(
      body: BlocConsumer<GetAllUserRoleCubit, GetAllUserRoleState>(
      listener: (context, state) {
        if (state is GetAllUserRoleFail) {
          showErrorToast('Error: ${state.error}');
        }
      },
      builder: (context, state) {
        if (state is GetAllUserRoleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllUserRoleSuccess) {
          return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
            listener: (context, deleteState) {
              if (deleteState is DeleteCategoryLoading) {
                // Handle delete category loading state
              } else if (deleteState is DeleteCategorySuccess) {
                showSuccessToast('User deleted successfully');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context
                      .read<GetCategoryDetailCubit>()
                      .getCategoryDetail();
                });
              } else if (deleteState is DeleteCategoryFail) {
                showErrorToast(
                    'Failed to delete category: ${deleteState.error}');
              }
            },
            builder: (context, deleteState) {
              final bool loading = deleteState is DeleteCategoryLoading;
              final String message = deleteState is DeleteCategoryFail
                  ? deleteState.error
                  : '';

              return AllUserRoleWidget();
            },
          );
        } else if (state is GetAllUserRoleFail) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return AllUserRoleWidget(

        );
      },
      ),
    ),) ;
  }


}


void showErrorToast(String error) {
  Fluttertoast.showToast(
    msg: error,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
  );
}

void showSuccessToast(String success) {
  Fluttertoast.showToast(
    msg: success,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
  );
}