import 'package:easy_invoice/bloc/delete/delete_size_cubit.dart';
import 'package:easy_invoice/bloc/get/SizePart/get_all_size_cubit.dart';
import 'package:easy_invoice/screen/UpdateSizeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../common/ToastMessage.dart';
import '../common/showDefaultDialog.dart';
import '../data/responseModel/GetAllPaganizationDataResponse.dart';

class AllSizePageWidget extends StatelessWidget {
  final List<PaganizationItem> sizes;
  final bool isLoading;


  const AllSizePageWidget({Key? key,
    required this.sizes,
    required this.isLoading,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith((states) => Colors.teal),
              columnSpacing: 40.0,
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
                    child:  Icon(
                      Icons.edit,
                      color: Colors.green.shade900,
                    ),
                  )),
                  DataCell(GestureDetector(
                    onTap: () {
                      showCustomDialog(title: 'Delete Size', content: 'Are you sure you want to delete this city?', confirmText: 'Yes', onConfirm: (){
                        context.read<DeleteSizeCubit>().deleteSize(sizes.id);

                      });
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
    );


  }
}

