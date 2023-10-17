import 'package:easy_invoice/bloc/delete/TownshipPart/township_delete_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../common/ApiHelper.dart';
import '../../common/GeneralPaganizationClass.dart';
import '../../common/showDefaultDialog.dart';
import '../../data/responseModel/TownshipsPart/AllTownshipResponse.dart';
import '../../screen/LocationPart/EditTownshipScreen.dart';

class TownshipWidget extends StatefulWidget {
  final bool isLoading;

  const TownshipWidget({super.key, required this.isLoading});

  @override
  State<TownshipWidget> createState() => _TownshipWidgetState();
}

class _TownshipWidgetState extends State<TownshipWidget> {
  List<Township> townships = [];

  @override
  void initState() {
    super.initState();
    fetchTownshipName();
  }

  Future<void> fetchTownshipName() async {
    final township = await ApiHelper.fetchTownshipName();
    setState(() {
      this.townships = township;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: PaginatedDataTable(
        columns: const [
          DataColumn(
              label: Text(
            'ID',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text('Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Action',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        ],
        source: TownshipData(townships, context),
        horizontalMargin: 20,
        dragStartBehavior: DragStartBehavior.down,
        arrowHeadColor: Colors.blueAccent,
        rowsPerPage: ((context.height -
                    GeneralPagination.topViewHeight -
                    GeneralPagination.paginateDataTableHeaderRowHeight -
                    GeneralPagination.pagerWidgetHeight) ~/
                GeneralPagination.paginateDataTableRowHeight)
            .toInt(),
        columnSpacing: 85,
      ),
    );
  }
}

class TownshipData extends DataTableSource {
  final List<Township> townships;
  final BuildContext context;

  TownshipData(this.townships, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= townships.length) {
      return null;
    }

    final township = townships[index];
    return DataRow(cells: [
      DataCell(Text(township.id.toString())),
      DataCell(Text(township.name.toString())),
      DataCell(Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.green.shade900,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditTownshipScreen(
                          city_id: township.city_id.toString(),
                          name: township.name,
                          id: township.id)));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              showCustomDialog(title: 'Delete Township', content: 'Are you sure you want to delete township?', confirmText: 'Yes', onConfirm: (){
                context
                    .read<TownshipDeleteCubit>()
                    .deleteTownship(township.id.toInt());
              });
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => townships.length;

  @override
  int get selectedRowCount => 0;
}
