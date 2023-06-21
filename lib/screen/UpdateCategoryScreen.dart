import 'package:easy_invoice/bloc/edit/edit_category_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/widget/EditCategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final int id;
  final String name;
  final String slug;
  const UpdateCategoryScreen({
    required this.id,
    required this.name,
    required this.slug,
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategoryScreen> {
   bool _isLoading=false;
   String message='';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCategoryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Category Screen'),
        ),
        body: BlocBuilder<EditCategoryCubit, EditCategoryState>(
          builder: (context, state) {
            if (state is EditCategoryLoading) {
              _isLoading = true;
               return EditCateWidget(
                  name: widget.name, slug: widget.slug, id: widget.id,isLoading: _isLoading,message: '',);
            } else if (state is EditCategorySuccess) {

              // Navigate back to the GetAllCategoryScreen and trigger a refresh
              Navigator.pop(context,EditCateWidget(name: widget.name, slug: widget.slug, id: widget.id, isLoading: _isLoading, message: message));

            } else if (state is EditCategoryFail) {
               return  EditCateWidget(  name: widget.name,
                  slug: widget.slug,id : widget.id,isLoading : false,message: 'Error : Failed to update category',);
            }
            _isLoading = false;
            return EditCateWidget(
                name: widget.name, slug: widget.slug, id: widget.id,isLoading: _isLoading,message : message);
          },
        ),
      ),
    );
  }
}
