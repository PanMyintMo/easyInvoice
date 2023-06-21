import 'package:easy_invoice/bloc/edit/edit_user_role_cubit.dart';
import 'package:easy_invoice/bloc/get/get_all_user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../bloc/delete/delete_user_role_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllUserRoleCubit>(
          create: (context) {
            final cubit = GetAllUserRoleCubit(getIt.call());
            cubit.getAllUserRole();
            return cubit;
          },
        ),
        BlocProvider<DeleteUserRoleCubit>(
          create: (context) => DeleteUserRoleCubit(getIt.call()),
        ),
        BlocProvider<EditUserRoleCubit>(
          create: (context) => EditUserRoleCubit(getIt.call()),
        ),
      ],
      child: Scaffold(
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

              return BlocConsumer<DeleteUserRoleCubit, DeleteUserRoleState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteUserRoleLoading) {
                    // Handle delete user role loading state
                  } else if (deleteState is DeleteUserRoleSuccess) {
                    showSuccessToast('User deleted successfully');
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<GetAllUserRoleCubit>()
                          .getAllUserRole();
                    });
                  } else if (deleteState is DeleteUserRoleFail) {
                    showErrorToast(
                        'Failed to delete user: ${deleteState.error}');
                  }
                },
                builder: (context, deleteState) {
                  final bool loading = deleteState is DeleteUserRoleLoading;
                  final String message = deleteState is DeleteUserRoleFail
                      ? deleteState.error
                      : '';

                  return AllUserRoleWidget(userData: state.getAllUserRole.data);
                },
              );
            } else if (state is GetAllUserRoleFail) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return const AllUserRoleWidget(userData: []);
          },
        ),
      ),
    );
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
