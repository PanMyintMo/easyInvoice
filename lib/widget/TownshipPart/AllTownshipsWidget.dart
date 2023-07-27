import 'package:easy_invoice/bloc/delete/TownshipPart/township_delete_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ApiHelper.dart';
import '../../data/responsemodel/TownshipsPart/AllTownshipResponse.dart';
import '../../screen/LocationPart/AddNewTownship.dart';
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
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddNewTownship()));
          }, child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Add New Township',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ),),
        ),
        Expanded(
          child: PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Action',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
            ],
            source: TownshipData(townships,context),
            horizontalMargin: 20,
            rowsPerPage: 8,
            columnSpacing: 85,
          ),
        ),
      ],
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
            icon:  const Icon(Icons.edit,color: Colors.green,),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    EditTownshipScreen(city_id: township.cityId.toString(),name: township.name, id: township.id)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: () {
              showDeleteConfirmationDialog(context,township.id,context.read<TownshipDeleteCubit>());

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


  void showDeleteConfirmationDialog(BuildContext context, int id, deleteCubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to delete this?'),
          actions: [
            TextButton(
              onPressed: () {
                // Delete Action
                deleteCubit.deleteTownship(id);
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

}