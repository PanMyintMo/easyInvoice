import 'package:flutter/material.dart';
import '../../data/responsemodel/ShopKeeperResponsePart/ShopKeeperRequestResponse.dart';
import '../../screen/shopkeeperPart/EditShopKeeperScreen.dart';
import '../../screen/shopkeeperPart/RequestShopKeeper.dart';


class ShopKeeperWidget extends StatefulWidget {

  final bool isLoading;
  final List<ShopRequestData> shopData;
  const ShopKeeperWidget({super.key, required this.isLoading, required this.shopData});

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
         child :   Column(
           children: [
             Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RequestShopKeeperScreen()),
                        );
                      },
                      child: const Text('Request Products'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Receive Products'),
                    ),
                  ),
                ],
              ),
             PaginatedDataTable(
               columns:  const [
                 DataColumn(label: Text('Id',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                 DataColumn(label: Text('Product Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                 DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                 DataColumn(label: Text('Action',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
               ],
               source: ShopData(widget.shopData,context),
               rowsPerPage: 8,
               arrowHeadColor : Colors.lightBlue,
               columnSpacing: 10,
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
    final shopItemCateId= shopData[index].productData.category_id;


    return DataRow(cells: [
      DataCell(Text(shopItem.id.toString())),
      DataCell(Text(shopItem.product_name.toString())),
      DataCell(Text(shopItem.quantity.toString())),
      DataCell(Row(
        children: [
          IconButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateShopKeeperScreen(id: shopItem.id.toInt(), quantity:  shopItem.quantity.toString(), categoryId: shopItemCateId.toString(), shopProductId: shopItem.product_id.toString(),  )));
          },
              icon: const Icon(Icons.edit,color: Colors.green,),
              ),
          IconButton(onPressed: (){



          }, icon: const Icon(Icons.delete,color: Colors.red,),


          ),
        ],
      )
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => shopData.length;

  @override
  int get selectedRowCount => 0;

}
