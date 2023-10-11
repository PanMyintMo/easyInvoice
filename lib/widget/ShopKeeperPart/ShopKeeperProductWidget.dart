import 'package:easy_invoice/screen/shopkeeperPart/RequestShopKeeper.dart';
import 'package:flutter/material.dart';

import '../../data/responseModel/ShopKeeperResponsePart/ShopProductListResponse.dart';
import '../../screen/WarehousePart/WareHouseTableScreen.dart';

class ShopKeeperProductWidget extends StatefulWidget {
  final bool isLoading;
  final List<ShopProductItem> productListItem;

  const ShopKeeperProductWidget(
      {super.key, required this.isLoading, required this.productListItem});

  @override
  State<ShopKeeperProductWidget> createState() =>
      _ShopKeeperProductWidgetState();
}

class _ShopKeeperProductWidgetState extends State<ShopKeeperProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WarehouseTableScreen()), // Replace WarehousePage() with your actual destination page
                    );
                  },
                  child: const Text(
                    "Warehouse Table",
                    style: TextStyle(
                      decoration:
                          TextDecoration.underline,color: Colors.blue // Add underline decoration
                    ),
                  )),
              TextButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestShopKeeperScreen()), // Replace WarehousePage() with your actual destination page
                );
              }, child: const Text("Request Product",style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue),))
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.teal),
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
                  rows: widget.productListItem.map((productListItem) {
                    return DataRow(cells: [
                      DataCell(Text(productListItem.id.toString())),
                      DataCell(Text(productListItem.product_name)),
                      DataCell(Text(productListItem.quantity.toString())),
                      DataCell(Text(productListItem.product_name)),
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
