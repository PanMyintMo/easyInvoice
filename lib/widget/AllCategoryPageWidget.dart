import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoryPageWidget extends StatelessWidget {
  const AllCategoryPageWidget(
      {Key? key,
      required this.categories,
     })
      : super(key: key);

  final List<CategoryData> categories;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCategoryDetailCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Category'),
        ),
        body: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Slug')),
            DataColumn(label: Text('Action')),
          ],
          rows: categories.map((category) {
            return category.data.map((item) {
              return DataRow(cells: [
                DataCell(Text(item.id.toString())),
                DataCell(Text(item.name)),
                DataCell(Text(item.slug)),
                DataCell(Text('')),
              ]);
            }).toList();
          }).expand((row) => row).toList(),
        ),
      )
      );

  }
}
