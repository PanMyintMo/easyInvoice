import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/get/CategoryPart/get_category_detail_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/ToastMessage.dart';
import '../data/responsemodel/GetAllPagnitaionDataResponse.dart';
import '../screen/UpdateCategoryScreen.dart';

class AllCategoryPageWidget extends StatefulWidget {
  final List<PaginationItem> categories;
  final bool isLoading;
  final String message;

  const AllCategoryPageWidget({
    Key? key,
    required this.categories,
    required this.isLoading,
    required this.message,
  }) : super(key: key);

  @override
  _AllCategoryPageWidgetState createState() => _AllCategoryPageWidgetState();
}

class _AllCategoryPageWidgetState extends State<AllCategoryPageWidget> {
  List<PaginationItem> displayCategories = [];
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    displayCategories.addAll(widget.categories);

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCategoryDetailCubit(getIt.call()),
      child: Column(
          children: [

            Padding(
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
            const SizedBox(height: 16),
            Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.teal),
                      columnSpacing: 7.0,
                      border: TableBorder.all(width: 0.2),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'ID',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Slug',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Update',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Delete',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                      rows: displayCategories.map((category) {
                        return
                          DataRow(
                          cells: [
                            DataCell(Text(category.id.toString())),
                            DataCell(Text(category.name)),
                            DataCell(Text(category.slug)),
                            DataCell(
                              GestureDetector(
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
                                    showToastMessage('Category Updated Successfully');
                                  } else if (result != null && result is String) {
                                    showToastMessage('Failed to update category: $result');
                                  }
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  showDeleteConfirmationDialog(
                                    context,
                                    category,
                                    context.read<DeleteCategoryCubit>(),
                                  );
                                },
                                child: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                if (widget.isLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),

    );
  }
}

void showDeleteConfirmationDialog(
    BuildContext context,
    PaginationItem item,
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
