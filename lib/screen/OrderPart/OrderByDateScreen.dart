import 'package:easy_invoice/screen/OrderPart/OrderDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:easy_invoice/bloc/post/DeliveryPart/fetch_order_by_date_cubit.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/OrderByDateRequestModel.dart';
import '../../bloc/delete/CountryPart/delete_country_cubit.dart';
import '../../data/responsemodel/MainPagePart/MainPageResponse.dart';
import '../../module/module.dart';

class FetchOrderByDateScreen extends StatelessWidget {
  const FetchOrderByDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(
          color: Colors.red, // Set the color of the navigation icon to black
        ),
        title: const Text(
          'All Order By Date Screen',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FetchOrderByDateCubit>(
            create: (context) => FetchOrderByDateCubit(getIt.call()),
          ),
          BlocProvider<DeleteCountryCubit>(
            create: (context) => DeleteCountryCubit(getIt.call()),
          ),
        ],
        child: FetchOrderByDateContent(),
      ),
    );
  }
}

class FetchOrderByDateContent extends StatefulWidget {
  @override
  State<FetchOrderByDateContent> createState() =>
      _FetchOrderByDateContentState();
}

class _FetchOrderByDateContentState extends State<FetchOrderByDateContent> {
  DateTime? _startDate;
  DateTime? _endDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  List<OrderDatas> orderFilterItem = [];

  final List<DataColumn> defaultColumns = const [
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
        'Delivery Company',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
    DataColumn(
      label: Text(
        'Status',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
    DataColumn(
      label: Text(
        'Action',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
  ];

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    )) ?? (_startDate ?? now);

    // Ensure that the picked date is not after today
    if (picked.isAfter(now)) {
      picked = now;
    }

    setState(() {
      _startDate = picked;
      final formattedDate = DateFormat('yyyy/MM/d').format(picked);
      startDateController.text = formattedDate;
    });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _endDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    )) ?? (_endDate ?? now);

    // Ensure that the picked date is not after today
    if (picked.isAfter(now)) {
      picked = now;
    }

    setState(() {
      _endDate = picked;
      final formattedDate = DateFormat('yyyy/MM/d').format(picked);
      endDateController.text = formattedDate;
    });
  }


  bool isDateValid() {
    if (_startDate != null && _endDate != null) {
      return _startDate!.isBefore(_endDate!);
    }
    return false; // Return false if both dates are not selected
  }


  @override
  Widget build(BuildContext context) {
   String? selectedAction;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Start Date:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: startDateController,
                        decoration: const InputDecoration(
                          hintText: 'Start Date',
                          suffixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder(),
                          labelText: 'Start Date',
                        ),
                        readOnly: true,
                        onTap: () async {
                          _selectStartDate(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("End Date",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: endDateController,
                        decoration: const InputDecoration(
                          hintText: 'End Date',
                          suffixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder(),
                          labelText: 'End Date',
                        ),
                        readOnly: true,
                        onTap: () async {
                          _selectEndDate(context);
                        },
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (isDateValid()) {
                      BlocProvider.of<FetchOrderByDateCubit>(context)
                          .orderFilterByDate(
                        OrderByDateRequest(
                          start_date: DateFormat('yyyy/MM/d')
                              .format(_startDate ?? DateTime.now()),
                          end_date: DateFormat('yyyy/MM/d')
                              .format(_endDate ?? DateTime.now()),
                        ),
                      );
                    } else {
                      // Show an error message here, for example, using a Snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'End date should be after the start date.'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )


              ],
            ),
          ),
          BlocBuilder<FetchOrderByDateCubit, FetchOrderByDateState>(
            builder: (context, state) {
              if (state is FetchOrderByDateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchOrderByDateSuccess) {
                orderFilterItem = state.fetchOrderByDate;
                if (orderFilterItem.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data found',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          border: TableBorder.all(width: 0.2),
                          headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.teal),
                          columns: defaultColumns,
                          rows: state.fetchOrderByDate.map((orderItem) {
                            return DataRow(cells: [
                              DataCell(Text(orderItem.order_id.toString())),
                              DataCell(Text(orderItem.firstname.toString())),
                              DataCell(Text(orderItem.mobile.toString())),
                              DataCell(
                                  Text(orderItem.delivery_company.toString())),
                              DataCell(Text(orderItem.status.toString())),
                              DataCell(
                                  DropdownButton<String>(
                                    hint: const Text("Select"),
                                    value: selectedAction,
                                    onChanged: (newAction) {
                                      setState(() {
                                        selectedAction = newAction;
                                      });
                                      if (newAction == 'View Order') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OrderDetailScreen(order_id: orderItem.order_id),
                                          ),
                                        );
                                      } else if (newAction == 'Edit Order') {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => EditOrderScreen(order_id: orderItem.order_id), // Replace with your edit screen
                                        //   ),
                                        // );
                                      } else if (newAction == 'Delete Order') {

                                      }
                                    },
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'View Order',
                                        child: Row(
                                          children: [
                                            Icon(Icons.eco_sharp),
                                            SizedBox(width: 8),
                                            Text('View Order'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Edit Order',
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit),
                                            SizedBox(width: 8),
                                            Text('Edit Order'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Delete Order',
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete),
                                            SizedBox(width: 8),
                                            Text('Delete Order'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              )

                            ]);
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }
              } else if (state is FetchOrderByDateFail) {
                return Center(child: Text(state.error));
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
