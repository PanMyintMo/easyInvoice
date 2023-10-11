import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/get/CategoryPart/get_category_detail_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/ToastMessage.dart';
import '../common/showDeleteConfirmationDialog.dart';
import '../data/responseModel/GetAllPaganizationDataResponse.dart';
import '../screen/UpdateCategoryScreen.dart';

class AllCategoryPageWidget extends StatefulWidget {
  final List<PaganizationItem> categories;
  final bool isLoading;


  const AllCategoryPageWidget({
    Key? key,
    required this.categories,
    required this.isLoading,

  }) : super(key: key);

  @override

  State<AllCategoryPageWidget> createState() => _AllCategoryPageWidgetState();

}

class _AllCategoryPageWidgetState extends State<AllCategoryPageWidget> {
  List<PaganizationItem> displayCategories = [];
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

            Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.teal),

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
                                child:  Icon(
                                  Icons.edit,
                                  color: Colors.green.shade900,
                                ),
                              ),
                            ),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  showDeleteConfirmationDialogs(context,"Are you sure you want to delete this category?",(){
                                    context.read<DeleteCategoryCubit>().deleteCategory(category.id);
                                  });
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

