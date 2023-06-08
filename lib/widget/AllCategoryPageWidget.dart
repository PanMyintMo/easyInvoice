import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoryPageWidget extends StatelessWidget {
  const AllCategoryPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCategoryDetailCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Category'),
        ),


      ),
    );
  }
}
