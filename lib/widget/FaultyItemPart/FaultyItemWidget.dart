import 'package:easy_invoice/bloc/delete/FaultyPart/delete_faulty_item_cubit.dart';
import 'package:easy_invoice/screen/FaultyItemPart/UpdateFaultyItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/showDeleteConfirmationDialog.dart';
import '../../data/responsemodel/FaultyItemPart/AllFaultyItems.dart';

class FaultyItemWidget extends StatelessWidget {
  final List<FaultyItemData> faultyItems;

  const FaultyItemWidget({Key? key, required this.faultyItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        PaginatedDataTable(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  UpdateFaultyItemScreen(quantity: faultyItem.quantity, id: faultyItem.id,)));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDeleteConfirmationDialogs(
                    context, "Are you sure you want to delete  this faulty item?",
                        () {
                      context
                          .read<DeleteFaultyItemCubit>()
                          .deleteFaultyItem(faultyItem.id);
                    });
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
