import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../bloc/delete/CityPart/delete_city_cubit.dart';
import '../../bloc/get/CityPart/fetch_all_city_cubit.dart';
import '../../common/GeneralPaganizationClass.dart';
import '../../common/showDefaultDialog.dart';
import '../../data/responseModel/CityPart/Cities.dart';
import '../../screen/LocationPart/EditCityScreen.dart';

class CitiesWidget extends StatelessWidget {
  final bool isLoading;
  final List<City> cities;
  const CitiesWidget({super.key, required this.isLoading, required this.cities});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
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
            rowsPerPage: ((context.height -
                GeneralPagination.topViewHeight -
                GeneralPagination.paginateDataTableHeaderRowHeight -
                GeneralPagination.pagerWidgetHeight) ~/
                GeneralPagination.paginateDataTableRowHeight)
                .toInt(),
            columnSpacing: 85,
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
            icon: Icon(Icons.edit,color: Colors.green.shade900,),
            onPressed: () async{
             final result=await Navigator.push(context, MaterialPageRoute(builder: (context) =>
                   EditCityScreen(country_id: city.country_id.toString(),name: city.name,id: city.id,)));

             if (result == true) {
              BlocProvider.of<FetchAllCityCubit>(context).fetchAllCity();

             }
             },
          ),
          IconButton(
            icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: () {

              showCustomDialog(title: 'Delete City', content: 'Are you sure you want to delete this city?', confirmText: '', onConfirm: (){
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
