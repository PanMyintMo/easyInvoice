import 'package:easy_invoice/bloc/delete/CountryPart/delete_country_cubit.dart';
import 'package:easy_invoice/screen/LocationPart/AddNewCountryScreen.dart';
import 'package:easy_invoice/screen/LocationPart/EditCountryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ApiHelper.dart';
import '../../common/showDeleteConfirmationDialog.dart';
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
            arrowHeadColor: Colors.blueAccent,
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
              showDeleteConfirmationDialogs(context,"Are you sure you want to delete this country?",(){
                context.read<DeleteCountryCubit>().deleteCountry(country.id);
              });
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

}
