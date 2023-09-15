import 'package:easy_invoice/bloc/edit/statusChange/shopkeeper_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../data/responsemodel/ShopKeeperResponsePart/DeliveredWarehouseRequest.dart';


class DeliverWarehouseToShopWidget extends StatefulWidget {
  final List<DeliveryWarehouseItem> deliverData;
  final bool isLoading;

  const DeliverWarehouseToShopWidget({super.key, required this.deliverData, required this.isLoading});

  @override
  State<DeliverWarehouseToShopWidget> createState() => _DeliverWarehouseToShopWidgetState();
}

class _DeliverWarehouseToShopWidgetState extends State<DeliverWarehouseToShopWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: PaginatedDataTable(
            columns: const [
              DataColumn(
                  label: Text(
                    'ShopKeeperId',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              DataColumn(
                  label: Text('Product Name',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Quantity',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Status',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
            ],
            source: ShopData(widget.deliverData, context),
            rowsPerPage: 8,
            arrowHeadColor: Colors.lightBlue,
            columnSpacing: 10,
          ),
        ),
        if(widget.isLoading)
         Container(
            color: Colors.black54,
             child: const Center(
               child: SpinKitFadingCircle(
                  color: Colors.white, size: 50.0),
           ),
           ),
      ],
    );
  }
}
class ShopData extends DataTableSource {
  final List<DeliveryWarehouseItem> deliverDataItems;
  final BuildContext context;

  ShopData(this.deliverDataItems, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= deliverDataItems.length) {
      return null;
    }
    final shopItem = deliverDataItems[index];

    return DataRow(cells: [
      DataCell(Text(shopItem.id.toString())),
      DataCell(Text(shopItem.product_name.toString())),
      DataCell(Text(shopItem.quantity.toString())),
      DataCell(
          ElevatedButton(onPressed: () {
          context.read<ShopkeeperStatusCubit>().shopkeeperStatus(shopItem.id);
          }, child: Text(shopItem.status.capitalizeFirst.toString()),
          )
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => deliverDataItems.length;

  @override
  int get selectedRowCount => 0;
}