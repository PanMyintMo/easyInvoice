import 'package:easy_invoice/bloc/delete/delete_size_cubit.dart';
import 'package:easy_invoice/bloc/get/get_all_size_cubit.dart';
import 'package:easy_invoice/data/responsemodel/GetAllSizeResponse.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/screen/UpdateSizeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/ToastMessage.dart';

class AllSizePageWidget extends StatelessWidget {
  final List<SizeItems> sizes;
  final bool isLoading;

  final String message;

  const AllSizePageWidget({Key? key,
    required this.sizes,
    required this.isLoading,
    required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetAllSizeCubit(getIt.call()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('All Size'),
            backgroundColor: Colors.redAccent.withOpacity(0.8), // Customize the background color here

          ),
          body: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Sizes',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding:  const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 5),
                          Text(
                            'Search:',
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

              const SizedBox(height: 10,),
              Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'ID',
                            style: TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Slug',
                            style: TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Update',
                            style: TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Delete',
                            style: TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],

                      rows: sizes.map((sizes) {
                        return DataRow(cells: [
                          DataCell(Text(sizes.id.toString())),
                          DataCell(Text(sizes.name)),
                          DataCell(Text(sizes.slug)),
                          DataCell(GestureDetector(
                            onTap: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateSizeScreen(
                                        id: sizes.id,
                                        name: sizes.name,
                                        slug: sizes.slug,
                                      ),
                                ),
                              );
                              if (result != null) {
                                BlocProvider.of<GetAllSizeCubit>(context)
                                    .getAllSizes();
                                showToastMessage(
                                    'Size Updated Successfully');
                              } else if (result != null && result is String) {
                                showToastMessage(
                                    'Failed to update sizes: $result');
                              }
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.yellow,
                            ),
                          )),
                          DataCell(GestureDetector(
                            onTap: () {
                              showDeleteConfirmationDialog(context, sizes,
                                  context.read<DeleteSizeCubit>());
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

void showDeleteConfirmationDialog(BuildContext context,
    SizeItems item,
    DeleteSizeCubit deleteSizeCubit,) {
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
              deleteSizeCubit.deleteSize(item.id);
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

