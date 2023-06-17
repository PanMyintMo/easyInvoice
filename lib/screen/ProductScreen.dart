import 'package:easy_invoice/bloc/post/sign_in_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/ProductWidget.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => SignInCubit(getIt.call()),
    child: Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SignInCubit,SignInState>(
        builder: (context,state){
          if(state is SignInLoading){}
          else if(state is SignInSuccess){}
          else if(state is SignInFail){}
          return const ProductWidget();
        },
      ),
    ),);

  }
}
