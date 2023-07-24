import 'package:easy_invoice/bloc/post/add_user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/ToastMessage.dart';
import '../module/module.dart';
import '../widget/AddUserRoleWidget.dart';

class UserAddScreen extends StatefulWidget {
  const UserAddScreen({Key? key}) : super(key: key);

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddUserRoleCubit(getIt.call()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Add User Role',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<AddUserRoleCubit, AddUserRoleState>(
          builder: (context, state) {
            if (state is AddUserRoleLoading) {
              return const UserWidget(isLoading: true);
            }
            else if (state is AddUserRoleSuccess) {
              showToastMessage(
                  'Successfully user added.');
              return const UserWidget(isLoading: false);
            }
            else if (state is AddUserRoleFail) {
              showToastMessage(
                  'Failed to add user. Please try again.');
              return const UserWidget(isLoading: false);
            } else {
              // Initial state or unknown state
              return const UserWidget(isLoading: false);
            }
          },
        ),
      ),
    );
  }
}

