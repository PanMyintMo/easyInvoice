import 'package:flutter/material.dart';

import '../../data/responsemodel/WarehousePart/WarehouseResponse.dart';
import '../../screen/shopkeeperPart/ShopKeeperRequestListScreen.dart';
class WarehouseTableWidget extends StatefulWidget {
  final bool isLoading;
  final List<WarehouseData> warehouseData;
  const WarehouseTableWidget({super.key, required this.isLoading, required this.warehouseData});

  @override
  State<WarehouseTableWidget> createState() => _WarehouseTableWidgetState();
}

class _WarehouseTableWidgetState extends State<WarehouseTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopKeeperRequestListScreen()));
            },
                child: const Text("Requesting Products",style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue,fontSize: 20),)),
          ),
          const SizedBox(height: 16,),
          Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
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
                    rows: widget.warehouseData.map((warehouseData) {
                      return DataRow(cells: [
                        DataCell(Text(warehouseData.id.toString())),
                        DataCell(Text(warehouseData.name)),
                        DataCell(Text(warehouseData.quantity.toString())),
                        DataCell(Text(warehouseData.buying_price)),

                      ]);
                    }).toList(),
                  ),
                ),
              ),
              // if (widget.isLoading)
              //   Container(
              //     color: Colors.black54,
              //     child: const Center(
              //       child: SpinKitFadingCircle(
              //           color: Colors.white, size: 50.0),
              //     ),
              //   ),
            ],
          ),
        ],
      );
  }
}
