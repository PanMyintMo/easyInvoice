import 'package:easy_invoice/bloc/edit/edit_size_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/widget/EditCategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/EditSizeWidget.dart';

class UpdateSizeScreen extends StatefulWidget {
  final int id;
  final String name;
  final String slug;


  const UpdateSizeScreen({
    required this.id,
    required this.name,
    required this.slug,
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateSizeScreen> createState() => _UpdateSizeState();
}

class _UpdateSizeState extends State<UpdateSizeScreen> {
   bool _isLoading=false;
   String message='';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSizeCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Category Screen'),
        ),
        body: BlocBuilder<EditSizeCubit, EditSizeState>(
          builder: (context, state) {
            if (state is EditSizeLoading) {
              _isLoading = true;
               return EditCateWidget(
                  name: widget.name, slug: widget.slug, id: widget.id,isLoading: _isLoading,message: '',);
            } else if (state is EditSizeSuccess) {
              // Navigate back to the GetAllSizeScreen and trigger a refresh
              Navigator.pop(context,EditSizeWidget(name: widget.name, slug: widget.slug, id: widget.id, isLoading: _isLoading, message: message));

            } else if (state is EditSizeFail) {
               return  EditSizeWidget(  name: widget.name,
                  slug: widget.slug,id : widget.id,isLoading : false,message: 'Error : Failed to update category',);
            }
            _isLoading = false;
            return EditSizeWidget(
                name: widget.name, slug: widget.slug, id: widget.id,isLoading: _isLoading,message : message);
          },
        ),
      ),
    );
  }
}
