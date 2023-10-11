import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../bloc/delete/DeliveryPart/delete_delivery_cubit.dart';
import '../../common/GeneralPaganizationClass.dart';
import '../../common/showDeleteConfirmationDialog.dart';
import '../../data/responseModel/DeliveryPart/FetchAllDeliveries.dart';
import '../../screen/DeliveryPart/UpdateDeliveryScreen.dart';

class FetchAllDeliveryWidget extends StatelessWidget {
  final List<DeliveriesItem> deliveriesItem;
  final bool isLoading;

  const FetchAllDeliveryWidget(
      {Key? key, required this.deliveriesItem, required this.isLoading})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: PaginatedDataTable(
        arrowHeadColor: Colors.blue.shade300,
        columns: const [
          DataColumn(label: Text('Cost')),
          DataColumn(label: Text('City')),
          DataColumn(label: Text('State')),
          DataColumn(label: Text('Company')),
          DataColumn(label: Text('Action')),
        ],
        source: DeliData(deliveriesItem, context),
        horizontalMargin: 20,
        rowsPerPage: ((context.height -
            GeneralPagination.topViewHeight -
            GeneralPagination.paginateDataTableHeaderRowHeight -
            GeneralPagination.pagerWidgetHeight) ~/
            GeneralPagination.paginateDataTableRowHeight)
            .toInt(),
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
      DataCell(Text(deliveriesItem.city_name.toString())),
      DataCell(Text(deliveriesItem.township_name.toString())),
      DataCell(Text(deliveriesItem.company_name.toString())),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green.shade900),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateDelivery(id: deliveriesItem.delivery_info_id,
                              city_id: deliveriesItem.city_id.toString(),
                              township_id: deliveriesItem.township_id
                                  .toString(),
                              basic_cost: deliveriesItem.basic_cost.toString(),
                              waiting_time: deliveriesItem.waiting_time
                                  .toString(),
                              company_id: deliveriesItem.company_id
                                  .toString(),)));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDeleteConfirmationDialogs(
                  context,
                  "Are you sure you want to delete this delivery item?",
                      () {
                    context
                        .read<DeleteDeliveryCubit>()
                        .deleteDelivery(deliveriesItem.delivery_info_id);
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
  int get rowCount => deliItem.length;

  @override
  int get selectedRowCount => 0;
}
