import 'package:easy_invoice/bloc/post/CategoryPart/add_category_cubit.dart';
import 'package:easy_invoice/common/ToastMessage.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/AddCategoryFromWidget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text('Category',style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),),
        ),
        body: BlocBuilder<AddCategoryCubit, AddCategoryState>(
          builder: (context, state) {
            if (state is AddCategoryLoading) {
              return const AddCategoryFromWidget(
                isLoading: true,

              );
            } else if (state is AddCategorySuccess) {
              showToastMessage(state.addCategoryResponse.message);
              Navigator.pop(context,true);

              return const AddCategoryFromWidget(
                isLoading: false,

              );

            } else if (state is AddCategoryFail) {
              return const AddCategoryFromWidget(
                isLoading: false,

              );
            }
            return const AddCategoryFromWidget(
              isLoading: false,

            );
          },
        ),
      ),
    );
  }
}
