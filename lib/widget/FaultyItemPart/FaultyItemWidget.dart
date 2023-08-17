import 'package:flutter/material.dart';
import '../../data/responsemodel/FaultyItemPart/AllFaultyItems.dart';
import '../../screen/FaultyItemPart/AddRequestFaultyItemScreen.dart';

class FaultyItemWidget extends StatelessWidget {
  final List<FaultyItemData> faultyItems;

  const FaultyItemWidget({Key? key, required this.faultyItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddRequestFaultyItem(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Add New Faulty Item',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,decoration: TextDecoration.underline,color: Colors.blue),
              ),
            ),
          ),
        ),
        Expanded(
          child: PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Product Name')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Action')),
            ],
            source: FaultyData(faultyItems, context),
            horizontalMargin: 20,
            rowsPerPage: 8,
            columnSpacing: 30,
          ),
        ),
      ],
    );
  }
}

class FaultyData extends DataTableSource {
  final List<FaultyItemData> faultyItems;
  final BuildContext context;

  FaultyData(this.faultyItems, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= faultyItems.length) {
      return null;
    }

    final FaultyItemData faultyItem = faultyItems[index];

    return DataRow(cells: [
      DataCell(Text(faultyItem.id.toString())),
      DataCell(Text(faultyItem.product_name.toString())),
      DataCell(Text(faultyItem.quantity.toString())),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.green),
              onPressed: () {
                // Handle edit action here
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Handle delete action here
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
  int get rowCount => faultyItems.length;

  @override
  int get selectedRowCount => 0;
}
