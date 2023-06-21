import 'package:easy_invoice/bloc/edit/edit_user_role_cubit.dart';
import 'package:easy_invoice/screen/AllUserRoleScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../module/module.dart';
import '../widget/EditUserRoleWidget.dart';
class UpdateUserRoleScreen extends StatefulWidget {

  final int id;
  final String name;
  final String email;
  final String password;
  final String utype;
  final String? newimage;

  const UpdateUserRoleScreen({Key? key, required this.id, required this.name, required this.password, required this.utype, this.newimage, required this.email}) : super(key: key);

  @override
  State<UpdateUserRoleScreen> createState() => _UpdateUserRoleScreenState();
}

class _UpdateUserRoleScreenState extends State<UpdateUserRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserRoleCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit User Role Screen'),),
        body: BlocBuilder<EditUserRoleCubit, EditUserRoleState>(
          builder: (context, state) {
            if (state is EditUserRoleLoading) {
             // _isLoading = true;
              return EditUserRoleWidget(id:widget.id,name : widget.name, email : widget.email,password : widget.password, utype : widget.utype, newimage : widget.newimage);

            } else if (state is EditUserRoleSuccess) {

              // Navigate back to the GetAllCategoryScreen and trigger a refresh
              Navigator.pop(context,AllUserRoleScreen());

            } else if (state is EditUserRoleFail) {
              return EditUserRoleWidget(id: widget.id, name : widget.name, email : widget.email,password : widget.password, utype : widget.utype, newimage : widget.newimage);
            }
          //  _isLoading = false;
            return EditUserRoleWidget(id:widget.id,name : widget.name, email : widget.email,password : widget.password, utype : widget.utype, newimage : widget.newimage);
          },
        ),
      ),
    );
  }
}
