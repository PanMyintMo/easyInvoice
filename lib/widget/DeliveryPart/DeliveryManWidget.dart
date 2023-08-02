import 'package:flutter/material.dart';

import '../../data/responsemodel/DeliveryPart/DeliveryManResponse.dart';

class DeliveryManWidget extends StatefulWidget {
  final List<DeliveryItemData> delivery;

  const DeliveryManWidget({Key? key, required this.delivery}) : super(key: key);

  @override
  State<DeliveryManWidget> createState() => _DeliveryManWidgetState();
}

class _DeliveryManWidgetState extends State<DeliveryManWidget> {
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
          source: Delivery(widget.delivery, context),
          horizontalMargin: 20,
          rowsPerPage: 8,
          columnSpacing: 30,
        ),
      ],
    );
  }
}

class Delivery extends DataTableSource {
  final List<DeliveryItemData> deliveryData;
  final BuildContext context;

  Delivery(this.deliveryData, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= deliveryData.length) {
      return null;
    }

    final DeliveryItemData deliveryItemData = deliveryData[index];

    return DataRow(cells: [
      DataCell(Text(deliveryItemData.id.toString())),
      DataCell(Text(deliveryItemData.product_name.toString())),
      DataCell(Text(deliveryItemData.quantity.toString())),
      DataCell(
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Handle delete action here
          },
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => deliveryData.length;

  @override
  int get selectedRowCount => 0;
}
