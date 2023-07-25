import 'package:flutter/material.dart';

import '../../common/ApiHelper.dart';
import '../../data/responsemodel/CityPart/Cities.dart';
import '../../screen/LocationPart/AddNewCity.dart';
class CitiesWidget extends StatefulWidget {
  final bool isLoading;
  const CitiesWidget({super.key, required this.isLoading});

  @override
  State<CitiesWidget> createState() => _CitiesWidgetState();
}

class _CitiesWidgetState extends State<CitiesWidget> {

  List<City> cities = [];
  @override
  void initState() {
    super.initState();
    fetchCityName();
  }


  Future<void> fetchCityName() async {
    final cities = await ApiHelper.fetchCityName();
    setState(() {
      this.cities = cities;
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
                builder: (context) => const AddNewCity()));
          }, child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Add New City',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ),),
        ),
        Expanded(
          child: PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
              DataColumn(label: Text('Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Action',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
            ],
            source: CityData(cities),
            horizontalMargin: 20,
            rowsPerPage: 8,
            columnSpacing: 85,
          ),
        ),
      ],
    );
  }
}

class CityData extends DataTableSource {
  final List<City> cities;

  CityData(this.cities);

  @override
  DataRow? getRow(int index) {
    if (index >= cities.length) {
      return null;
    }

    final city = cities[index];
    return DataRow(cells: [
      DataCell(Text(city.id.toString())),
      DataCell(Text(city.name.toString())),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit,color: Colors.green,),
            onPressed: () {
              // Implement the edit functionality here
              // For example, show a dialog to edit the country details
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: () {
              // Implement the edit functionality here
              // For example, show a dialog to edit the country details
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => cities.length;

  @override
  int get selectedRowCount => 0;
}
