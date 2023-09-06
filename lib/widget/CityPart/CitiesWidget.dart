import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/delete/CityPart/delete_city_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../common/showDeleteConfirmationDialog.dart';
import '../../data/responsemodel/CityPart/Cities.dart';
import '../../screen/LocationPart/AddNewCity.dart';
import '../../screen/LocationPart/EditCityScreen.dart';

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
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('ID',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                DataColumn(label: Text('Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Action',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              ],
              source: CityData(cities,context),
              horizontalMargin: 20,
              arrowHeadColor: Colors.blueAccent,
              rowsPerPage: 8,
              columnSpacing: 85,
            ),
          ),
        ),
      ],
    );
  }
}

class CityData extends DataTableSource {
  final List<City> cities;
  final BuildContext context;
  CityData(this.cities, this.context);

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
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                   EditCityScreen(country_id: city.countryId.toString(),name: city.name,id: city.id,)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: () {
              showDeleteConfirmationDialogs(context,"Are you sure you want to delete this city?",(){
                context.read<DeleteCityCubit>().deleteCity(city.id);
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
  int get rowCount => cities.length;

  @override
  int get selectedRowCount => 0;

}
