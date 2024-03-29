import 'package:easy_invoice/bloc/delete/ShopKeeperPart/delete_shop_keeper_product_request_cubit.dart';
import 'package:easy_invoice/screen/shopkeeperPart/DeliverWarehouseToShopkeeperScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../bloc/get/ShopKeeperPart/shop_keeper_request_cubit.dart';
import '../../common/GeneralPaganizationClass.dart';
import '../../common/showDefaultDialog.dart';
import '../../data/responseModel/ShopKeeperResponsePart/ShopKeeperRequestResponse.dart';
import '../../screen/shopkeeperPart/EditShopKeeperScreen.dart';
import '../../screen/shopkeeperPart/RequestShopKeeper.dart';

class ShopKeeperWidget extends StatefulWidget {
  final bool isLoading;
  final List<ShopRequestData> shopData;

  const ShopKeeperWidget(
      {super.key, required this.isLoading, required this.shopData});

  @override
  State<ShopKeeperWidget> createState() => _ShopKeeperWidgetState();
}

class _ShopKeeperWidgetState extends State<ShopKeeperWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RequestShopKeeperScreen()),
                        );
                        if (result == true) {
                          BlocProvider.of<ShopKeeperRequestCubit>(context)
                              .shopkeeperRequestList();
                        }
                      },
                      child: const Text(
                        'Request Products',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) =>
                                    const DeliverWarehouseToShopkeeperScreen()));
                      },
                      child: const Text(
                        'Receive Products',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: PaginatedDataTable(
                  columns: const [
                    DataColumn(
                        label: Text(
                      'Id',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        label: Text('Action',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                  ],
                  source: ShopData(widget.shopData, context),
                  rowsPerPage: ((context.height -
                              GeneralPagination.topViewHeight -
                              GeneralPagination
                                  .paginateDataTableHeaderRowHeight -
                              GeneralPagination.pagerWidgetHeight) ~/
                          GeneralPagination.paginateDataTableRowHeight)
                      .toInt(),
                  arrowHeadColor: Colors.lightBlue,
                  columnSpacing: 10,
                ),
              )
            ],
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
    final shopItemCateId = shopData[index].productData.category_id;

    return DataRow(cells: [
      DataCell(Text(shopItem.id.toString())),
      DataCell(Text(shopItem.product_name.toString())),
      DataCell(Text(shopItem.quantity.toString())),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateShopKeeperScreen(
                            id: shopItem.id.toInt(),
                            quantity: shopItem.quantity.toString(),
                            categoryId: shopItemCateId.toString(),
                            shopProductId: shopItem.product_id.toString(),
                          )));
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              showCustomDialog(
                  title: 'Delete ShopKeeper',
                  content: 'Are you sure you want to delete  this shopkeeper?',
                  confirmText: 'Yes',
                  onConfirm: () {
                    context
                        .read<DeleteShopKeeperProductRequestCubit>()
                        .deleteShopKeeperRequestProduct(shopItem.id);
                  });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => shopData.length;

  @override
  int get selectedRowCount => 0;
}
