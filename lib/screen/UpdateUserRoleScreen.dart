import 'package:easy_invoice/bloc/edit/edit_user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/ToastMessage.dart';
import '../data/responseModel/UserRoleResponse.dart';
import '../module/module.dart';
import '../widget/EditUserRoleWidget.dart';

class UpdateUserRoleScreen extends StatefulWidget {
  final UserData user;
  const UpdateUserRoleScreen({Key? key, required this.user,}) : super(key: key);

  @override
  State<UpdateUserRoleScreen> createState() => _UpdateUserRoleScreenState();
}

class _UpdateUserRoleScreenState extends State<UpdateUserRoleScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditUserRoleCubit>(
      create: (context) => EditUserRoleCubit(getIt.call()),
      child: BlocConsumer<EditUserRoleCubit, EditUserRoleState>(
        listener: (context, state) {
          if (state is EditUserRoleLoading) {
            // Handle loading state if needed
          } else if (state is EditUserRoleSuccess) {
            showToastMessage('User account updated successfully.',
                duration: 3000);
            // Return the updated data to the UserDetailProfileScreen
            Navigator.pop(context, true);
          } else if (state is EditUserRoleFail) {
            showToastMessage(state.error, duration: 3000);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.redAccent.withOpacity(0.3),
                      Colors.pink.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
              ),
              title: const Center(
                child: Text(
                  'Edit User Role Detail Profile',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            body: EditUserRoleWidget(
              user:widget.user),
          );
        },
      ),
    );
  }
}
