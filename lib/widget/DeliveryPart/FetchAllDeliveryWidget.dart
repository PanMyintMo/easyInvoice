import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/delete/DeliveryPart/delete_delivery_cubit.dart';
import '../../common/showDeleteConfirmationDialog.dart';
import '../../data/responsemodel/DeliveryPart/FetchAllDeliveries.dart';

class FetchAllDeliveryWidget extends StatelessWidget {
  final List<DeliveriesItem> deliveriesItem;
  final bool isLoading;

  const FetchAllDeliveryWidget({Key? key, required this.deliveriesItem, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: PaginatedDataTable(
        columns: const [
          DataColumn(label: Text('Cost')),
          DataColumn(label: Text('City')),
          DataColumn(label: Text('State')),
          DataColumn(label: Text('Company')),
          DataColumn(label: Text('Action')),
        ],
        source: DeliData(deliveriesItem, context),
        horizontalMargin: 20,
        rowsPerPage: 8,
        columnSpacing: 30,
      ),
    );
  }
}

class DeliData extends DataTableSource {
  final List<DeliveriesItem> deliItem;
  final BuildContext context;

  DeliData(this.deliItem, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= deliItem.length) {
      return null;
    }

    final DeliveriesItem deliveriesItem = deliItem[index];

    return DataRow(cells: [
      DataCell(Text(deliveriesItem.basic_cost.toString())),
      DataCell(Text(deliveriesItem.city_id.toString())),
      DataCell(Text(deliveriesItem.township_name.toString())),
      DataCell(Text(deliveriesItem.company_id.toString())),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // showDeleteConfirmationDialogs(
                //   context,
                //   "Are you sure you want to delete this delivery item?",
                //       () {
                //     context
                //         .read<DeleteDeliveryCubit>()
                //         .deleteDelivery(deliveriesItem);
                //   },
                // );
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
  int get rowCount => deliItem.length;

  @override
  int get selectedRowCount => 0;
}

