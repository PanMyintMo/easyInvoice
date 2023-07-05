import 'package:easy_invoice/bloc/post/add_user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return  BlocProvider(create: (context) => AddUserRoleCubit(getIt.call()),
      child: Scaffold(
        body: BlocBuilder<AddUserRoleCubit,AddUserRoleState>(
          builder: (context,state){
            if(state is AddUserRoleLoading){}
            else if(state is AddUserRoleSuccess){
            }
            else if(state is AddUserRoleFail){}
            return  const UserWidget();
          },
        ),
      )
    );
  }
}
