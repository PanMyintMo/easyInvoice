import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/ToastMessage.dart';
import '../screen/UpdateCategoryScreen.dart';

class AllCategoryPageWidget extends StatelessWidget {
  final List<CategoryItem> categories;
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
            title: const Center(child: Text('All Category')),
            backgroundColor: Colors.redAccent
                .withOpacity(0.8), // Customize the background color here
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.search),
                              SizedBox(width: 5),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter your search',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'ID',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Slug',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Update',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Delete',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                      rows: categories.map((category) {
                        return
                          DataRow(
                              cells: [
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
                                BlocProvider.of<GetCategoryDetailCubit>(context)
                                    .getCategoryDetail();
                                showToastMessage(
                                    'Category Updated Successfully');
                              } else if (result != null && result is String) {
                                showToastMessage(
                                    'Failed to update category: $result');
                              }
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.yellow,
                            ),
                          )),
                          DataCell(GestureDetector(
                            onTap: () {
                              showDeleteConfirmationDialog(context, category,
                                  context.read<DeleteCategoryCubit>());
                            },
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                  if (isLoading)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: SpinKitFadingCircle(
                            color: Colors.white, size: 50.0),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ));
  }
}

void showDeleteConfirmationDialog(
  BuildContext context,
  CategoryItem item,
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
