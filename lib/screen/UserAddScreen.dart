import 'package:easy_invoice/bloc/post/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../module/module.dart';
import '../widget/UserWidget.dart';

class UserAddScreen extends StatefulWidget {
  const UserAddScreen({Key? key}) : super(key: key);

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => UserCubit(getIt.call()),
      child: Scaffold(
        body: BlocBuilder<UserCubit,UserState>(
          builder: (context,state){
            if(state is UserLoading){}
            else if(state is UserSuccess){
            }
            else if(state is UserFailed){}
            return  const UserWidget();
          },
        ),
      )
    );
  }
}
