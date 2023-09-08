import 'package:flutter/material.dart';
import '../../data/responsemodel/DeliveryPart/FetchAllOrderByDate.dart';

class FetchOrderByDateWidget extends StatefulWidget {
  final List<OrderFilterItem> orderFilterItem;

  const FetchOrderByDateWidget({super.key, required this.orderFilterItem});

  @override
  State<FetchOrderByDateWidget> createState() => _FetchOrderByDateWidgetState();
}

class _FetchOrderByDateWidgetState extends State<FetchOrderByDateWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
       children: [
         SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: DataTable(
               border: TableBorder.all(width: 0.2),
               headingRowColor:
               MaterialStateColor.resolveWith((states) => Colors.teal),
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
                     'Mobile',
                     style: TextStyle(fontSize: 16, color: Colors.white),
                   ),
                 ),
                 DataColumn(
                   label: Text(
                     'Status',
                     style: TextStyle(fontSize: 16, color: Colors.white),
                   ),
                 ),
               ],
               rows: widget.orderFilterItem.map((orderItem) {
                 return DataRow(cells: [
                   DataCell(Text(orderItem.id.toString())),
                   DataCell(Text(orderItem.firstname.toString())),
                   DataCell(Text(orderItem.mobile.toString())),
                   DataCell(Text(orderItem.delivery_company.toString())),
                 ]);
               }).toList(),
             ),
           ),
         )
       ],
    );

  }
}
