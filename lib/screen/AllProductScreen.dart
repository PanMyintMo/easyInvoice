import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post/add_user_role_cubit.dart';
import '../module/module.dart';
import '../widget/AllProductWidget.dart';


class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AddUserRoleCubit(getIt.call()),
        child: Scaffold(
          body: BlocBuilder<AddUserRoleCubit,AddUserRoleState>(
            builder: (context,state){
              if(state is AddUserRoleLoading){}
              else if(state is AddUserRoleSuccess){
              }
              else if(state is AddUserRoleFail){}
              return  const AllProductWidget();
            },
          ),
        )
    );

  }
}