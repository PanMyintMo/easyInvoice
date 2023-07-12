import 'package:easy_invoice/bloc/edit/edit_user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/ToastMessage.dart';

import '../module/module.dart';
import '../widget/EditUserRoleWidget.dart';

class UpdateUserRoleScreen extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String password;
  final String utype;
  final String? newimage;

  const UpdateUserRoleScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.password,
    required this.utype,
    this.newimage,
    required this.email,
  }) : super(key: key);

  @override
  State<UpdateUserRoleScreen> createState() => _UpdateUserRoleScreenState();
}

class _UpdateUserRoleScreenState extends State<UpdateUserRoleScreen> {
  bool isSaving = false; // Add a new variable to track saving state

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditUserRoleCubit>(
      create: (context) => EditUserRoleCubit(getIt.call()),
      child: BlocConsumer<EditUserRoleCubit, EditUserRoleState>(
        listener: (context, state) {
          if (state is EditUserRoleLoading) {
            setState(() {
              isSaving = true; // Update the saving state
            });
          } else if (state is EditUserRoleSuccess) {
            showToastMessage('User account updated successfully.',
                duration: 3000);
            // Navigate back to the GetAllUserRoleScreen and trigger a refresh
            Navigator.pop(context, true);
          } else if (state is EditUserRoleFail) {
            showToastMessage(state.error, duration: 3000);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Edit User Role Screen')),
            body: EditUserRoleWidget(
              id: widget.id,
              name: widget.name,
              email: widget.email,
              password: widget.password,
              utype: widget.utype,
              newimage: widget.newimage,
            ),
          );
        },
      ),
    );
  }
}
