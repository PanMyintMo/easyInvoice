import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/AllCategoryPageWidget.dart';

class AllCategoryDetailPage extends StatelessWidget {
  const AllCategoryDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetCategoryDetailCubit>(
          create: (context) {
            final cubit = GetCategoryDetailCubit(getIt.call());
            cubit.getCategoryDetail(); // call category detail
            return cubit;
          },
        ),
        BlocProvider<DeleteCategoryCubit>(
          create: (context) => DeleteCategoryCubit(getIt.call()),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<GetCategoryDetailCubit, GetCategoryDetailState>(
          builder: (context, state) {
            if (state is GetCategoryDetailLoading) {
              return const Center(child: Text('Loading!'));
            } else if (state is GetCategoryDetailSuccess) {
              return AllCategoryPageWidget(categories: state.getAllCategoryDetail);
            } else if (state is GetCategoryDetailFail) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const AllCategoryPageWidget(categories: []);
          },
        ),
      ),
    );
  }
}
