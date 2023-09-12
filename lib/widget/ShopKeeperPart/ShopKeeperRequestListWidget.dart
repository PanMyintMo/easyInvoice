import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/responsemodel/ShopKeeperResponsePart/ShopKeeperRequestResponse.dart';
class ShopKeeperRequestListWidget extends StatefulWidget {
  final bool isLoading = false;
 final List<ShopRequestData> shopData;

  const ShopKeeperRequestListWidget({super.key, required bool isLoading, required this.shopData});

  @override
  State<ShopKeeperRequestListWidget> createState() => _ShopKeeperRequestListWidgetState();
}

class _ShopKeeperRequestListWidgetState extends State<ShopKeeperRequestListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PaginatedDataTable(
            columns:  const [
              DataColumn(label: Text('Number',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Product Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Action',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
            ],
            source: ShopData(widget.shopData,context),
            rowsPerPage: 8,
            arrowHeadColor : Colors.lightBlue,
            columnSpacing: 10,
          ),
        ),
      ],
    );
  }
}

class ShopData extends DataTableSource {
  final List<ShopRequestData> shopData;
  final BuildContext context;
  ShopData(this.shopData, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= shopData.length) {
      return null;
    }
    final shopItem = shopData[index];
    return DataRow(cells: [
      DataCell(Text(shopItem.id.toString())),
      DataCell(Text(shopItem.product_name.toString())),
      DataCell(Text(shopItem.quantity.toString())),
      DataCell(ElevatedButton(onPressed: (){

      }, child: Text(shopItem.status.capitalizeFirst.toString()))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => shopData.length;

  @override
  int get selectedRowCount => 0;

}
