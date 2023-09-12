import 'package:easy_invoice/bloc/delete/CityPart/delete_ward_cubit.dart';
import 'package:easy_invoice/data/responsemodel/CityPart/Wards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/showDeleteConfirmationDialog.dart';


class WardsWidget extends StatelessWidget {
  final bool isLoading;
  final List<Ward> ward;

  const WardsWidget({Key? key, required this.isLoading, required this.ward})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: PaginatedDataTable(
            columns: const [
              DataColumn(
                label: Text(
                  'ID',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Action',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            source: WardData(ward, context),
            horizontalMargin: 20,
            arrowHeadColor: Colors.blueAccent,
            rowsPerPage: 8,
            columnSpacing: 85,
          ),
        ),
      ],
    );
  }
}

class WardData extends DataTableSource {
  final List<Ward> ward;
  final BuildContext context;

  WardData(this.ward, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= ward.length) {
      return null;
    }

    final wards = ward[index];
    return DataRow(cells: [
      DataCell(Text(wards.id.toString())),
      DataCell(Text(wards.ward_name.toString())),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                  // MaterialPageRoute(
                  //   builder: (context) => EditCityScreen(
                  //     country_id: wards.state_id.toString(),
                  //     name: streets.street_name,
                  //     id: streets.id,
                  //   ),
                  // ),
               // );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDeleteConfirmationDialogs(
                  context,
                  "Are you sure you want to delete this street?",
                      () {
                    context.read<DeleteWardCubit>().deleteWard(wards.id);
                  },
                );
              },
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => ward.length;

  @override
  int get selectedRowCount => 0;
}
