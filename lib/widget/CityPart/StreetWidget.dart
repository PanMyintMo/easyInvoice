import 'package:easy_invoice/bloc/delete/CityPart/delete_street_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/showDeleteConfirmationDialog.dart';
import '../../data/responsemodel/CityPart/Street.dart';
import '../../screen/LocationPart/EditCityScreen.dart';

class StreetWidget extends StatelessWidget {
  final bool isLoading;
  final List<Street> street;

  const StreetWidget({Key? key, required this.isLoading, required this.street})
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
            source: StreetData(street, context),
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

class StreetData extends DataTableSource {
  final List<Street> street;
  final BuildContext context;

  StreetData(this.street, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= street.length) {
      return null;
    }

    final streets = street[index];
    return DataRow(cells: [
      DataCell(Text(streets.id.toString())),
      DataCell(Text(streets.street_name.toString())),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCityScreen(
                      country_id: streets.ward_id.toString(),
                      name: streets.street_name,
                      id: streets.id,
                    ),
                  ),
                );
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
                    context.read<DeleteStreetCubit>().deleteStreet(streets.id);
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
  int get rowCount => street.length;

  @override
  int get selectedRowCount => 0;
}