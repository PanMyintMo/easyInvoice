import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:easy_invoice/bloc/post/DeliveryPart/fetch_order_by_date_cubit.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/OrderByDateRequestModel.dart';
import '../../bloc/delete/CountryPart/delete_country_cubit.dart';
import '../../module/module.dart';
import '../../widget/OrderPart/OrderByDateWidget.dart';

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
  State<FetchOrderByDateContent> createState() => _FetchOrderByDateContentState();
}

class _FetchOrderByDateContentState extends State<FetchOrderByDateContent> {
  DateTime? _selectedDate; // Add a variable to store the selected date
  TextEditingController textEditingController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    )) ??
        DateTime.now();

    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        final formattedDate = DateFormat('yyyy-MM-d').format(picked);
        textEditingController.text =
            formattedDate; // Set the selected date in the search bar.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text(
                  "Select Date:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Date',
                      suffixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(),
                      labelText: 'Date',
                    ),
                    readOnly: true,
                    onTap: () async {
                      _selectDate(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<FetchOrderByDateCubit>(context)
                        .orderFilterByDate(
                      OrderByDateRequest(
                        date: textEditingController.text.toString(),
                      ),
                    );
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<FetchOrderByDateCubit, FetchOrderByDateState>(
            builder: (context, state) {
              if (state is FetchOrderByDateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchOrderByDateSuccess) {
                return FetchOrderByDateWidget(
                  orderFilterItem: state.fetchOrderByDate,
                );
              } else if (state is FetchOrderByDateFail) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
