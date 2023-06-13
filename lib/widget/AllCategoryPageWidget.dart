import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screen/UpdateCategoryScreen.dart';

class AllCategoryPageWidget extends StatelessWidget {
  final List<CategoryData> categories;
  final bool isLoading;

  final String message;

  const AllCategoryPageWidget(
      {Key? key,
      required this.categories,
      required this.isLoading,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetCategoryDetailCubit(getIt.call()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('All Category'),
          ),
          body: Stack(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Slug')),
                  DataColumn(label: Text('Update')),
                  DataColumn(label: Text('Delete')),
                ],
                rows: categories.map((category) {
                  return DataRow(cells: [
                    DataCell(Text(category.id.toString())),
                    DataCell(Text(category.name)),
                    DataCell(Text(category.slug)),
                    DataCell(GestureDetector(
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateCategoryScreen(
                              id: category.id,
                              name: category.name,
                              slug: category.slug,
                            ),
                          ),
                        );
                        if (result != null) {
                          BlocProvider.of<GetCategoryDetailCubit>(context).getCategoryDetail();
                          showToastMessage('Category Updated Successfully');
                        } else if (result != null && result is String) {
                          showErrorToast('Failed to update category: $result');
                        }
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.yellow,
                      ),
                    )),
                    DataCell(GestureDetector(
                      onTap: () {
                        showDeleteConfirmationDialog(context, category, context.read<DeleteCategoryCubit>());
                      },
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    )),
                  ]);
                }).toList(),
              ),
              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: SpinKitFadingCircle(color: Colors.white, size: 50.0),
                  ),
                ),
            ],
          ),

        ));
  }

  void showToastMessage(String success) {
    Fluttertoast.showToast(
      msg: success,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

  void showErrorToast(String error) {
    Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }
}

void showDeleteConfirmationDialog(
    BuildContext context,
    CategoryData item,
    DeleteCategoryCubit deleteCategoryCubit,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              // Delete Action
              deleteCategoryCubit.deleteCategory(item.id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

