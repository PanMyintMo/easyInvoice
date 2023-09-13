import 'package:flutter/material.dart';

import '../../data/responsemodel/WarehousePart/WarehouseResponse.dart';
class WarehouseTableWidget extends StatelessWidget {
  final bool isLoading;
  final List<WarehouseData> warehouseData;
  const WarehouseTableWidget({super.key, required this.isLoading, required this.warehouseData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dividerThickness: 2,
          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.teal),
          columnSpacing: 40.0,
          columns: const [
            DataColumn(
              label: Text(
                'ID',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Quantity',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Buying Price',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
          rows: warehouseData.map((warehouseData) {
            return DataRow(cells: [
              DataCell(Text(warehouseData.id.toString())),
              DataCell(Text(warehouseData.name)),
              DataCell(Text(warehouseData.quantity.toString())),
              DataCell(Text(warehouseData.buying_price)),

            ]);
          }).toList(),
        ),
      ),
    );
  }
}
