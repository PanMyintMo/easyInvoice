import 'package:easy_invoice/bloc/edit/statusChange/delivery_man_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/responseModel/DeliveryPart/DeliveryManResponse.dart';


class DeliveryManWidget extends StatefulWidget {
  final List<DeliveryItemData> delivery;
  final bool isLoading;

  const DeliveryManWidget({Key? key, required this.delivery, required this.isLoading}) : super(key: key);

  @override
  State<DeliveryManWidget> createState() => _DeliveryManWidgetState();
}

class _DeliveryManWidgetState extends State<DeliveryManWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: PaginatedDataTable(

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
        ),
        if(widget.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
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
      DataCell(ElevatedButton(onPressed: () {
        context.read<DeliveryManStatusCubit>().deliveryManStatus(deliveryItemData.id);
      }, child: Text(deliveryItemData.status.capitalizeFirst.toString()),)
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
