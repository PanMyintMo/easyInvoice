import 'package:easy_invoice/bloc/delete/CountryPart/delete_country_cubit.dart';
import 'package:easy_invoice/screen/LocationPart/AddNewCountryScreen.dart';
import 'package:easy_invoice/screen/LocationPart/EditCountryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ApiHelper.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';

class CountryWidget extends StatefulWidget {
  final bool isLoading;

  const CountryWidget({super.key, required this.isLoading});

  @override
  State<CountryWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    fetchCountyName();
  }

  Future<void> fetchCountyName() async {
    final countries = await ApiHelper.fetchCountryName();
    setState(() {
      this.countries = countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddNewCountryScreen()));
          }, child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Add New Country',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ),),
        ),
        Expanded(
          child: PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Action',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
            ],
            source: CountryData(countries,context),
            horizontalMargin: 15,
            rowsPerPage: 8,
            columnSpacing: 70,
          ),
        ),
      ],
    );
  }
}

class CountryData extends DataTableSource {
  final List<Country> countries;
  final BuildContext context;
  CountryData(this.countries,this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= countries.length) {
      return null;
    }

    final country = countries[index];
    return DataRow(cells: [
      DataCell(Text(country.id.toString())),
      DataCell(Text(country.name.toString())),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit,color: Colors.green,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
               EditCountryScreen(id: country.id,name: country.name)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: () {
            showDeleteConfirmationDialog(context,country.id,context.read<DeleteCountryCubit>());
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => countries.length;

  @override
  int get selectedRowCount => 0;

  void showDeleteConfirmationDialog(BuildContext context,int id, deleteCubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to delete this?'),
          actions: [
            TextButton(
              onPressed: () {
                // Delete Action
                deleteCubit.deleteCountry(id);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
