import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/screen/OrderPart/OrderDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:easy_invoice/bloc/post/DeliveryPart/fetch_order_by_date_cubit.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/OrderByDateRequestModel.dart';
import '../../bloc/delete/CountryPart/delete_country_cubit.dart';
import '../../data/responseModel/MainPagePart/MainPageResponse.dart';
import '../../module/module.dart';
import 'EditOrderScreen.dart';

class FetchOrderByDateScreen extends StatelessWidget {
  const FetchOrderByDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AdaptiveTheme.of(context)
              .theme
              .iconTheme
              .color, // Set the color of the navigation icon to black
        ),
        title: Text(
          'All Order By Date Screen',
          style: TextStyle(
              color: AdaptiveTheme.of(context).theme.iconTheme.color,
              fontSize: 16),
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

  Future pickDateRange(DateTimeRange? newDateRange) async {
    if (newDateRange != null) {
      setState(() {
        _startDate = newDateRange.start;
        _endDate = newDateRange.end;
        final formattedStartDate = DateFormat('yyyy/MM/d').format(_startDate!);
        final formattedEndDate = DateFormat('yyyy/MM/d').format(_endDate!);
        startDateController.text = formattedStartDate;
        endDateController.text = formattedEndDate;
      });
    }
  }

  bool isDateValid() {
    if (_startDate != null && _endDate != null) {
      return _startDate!.isBefore(_endDate!) || _startDate == _endDate;
    }
    return false; // Return false if both dates are not selected
  }

  @override
  Widget build(BuildContext context) {
    String? selectedAction;
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5,bottom: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Start Date:",
                              style: TextStyle(
                                  color: AdaptiveTheme.of(context)
                                      .theme
                                      .iconTheme
                                      .color),
                            ),
                            const SizedBox(
                              height: 16,
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
                                final pickedDateRange =
                                    await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                pickDateRange(pickedDateRange);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("End Date:",
                                style: TextStyle(
                                    color: AdaptiveTheme.of(context)
                                        .theme
                                        .iconTheme
                                        .color)),
                            const SizedBox(height: 16),
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
                                final pickedDateRange =
                                    await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                pickDateRange(pickedDateRange);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'End date should be after the start date.'),
                            ),
                          );
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
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
                              DataCell(Text(orderItem.company_name.toString())),
                              DataCell(Text(orderItem.status.toString())),
                              DataCell(DropdownButton<String>(
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
                                        builder: (context) => OrderDetailScreen(
                                            order_id: orderItem.order_id),
                                      ),
                                    );
                                  } else if (newAction == 'Edit Order') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditOrderScreen(
                                            orderId: orderItem
                                                .order_id), // Replace with your edit screen
                                      ),
                                    );
                                  } else if (newAction == 'Delete Order') {}
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
                              ))
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
