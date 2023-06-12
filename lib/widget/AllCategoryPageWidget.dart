import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen/UpdateCategoryScreen.dart';

class AllCategoryPageWidget extends StatelessWidget {
  final List<CategoryData> categories;

  const AllCategoryPageWidget(
      {Key? key,
      required this.categories,
     })
      : super(key: key);

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
            DataColumn(label: Text('Update')),
            DataColumn(label: Text('Delete')),
          ],
          rows: categories.map((category) {
            return category.data.map((item) {
              return DataRow(cells: [
                DataCell(Text(item.id.toString())),
                DataCell(Text(item.name)),
                DataCell(Text(item.slug)),
                DataCell(
                    GestureDetector(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) =>   UpdateCategoryScreen(id : item.id,name :item.name,slug :item.slug)));
                      },
                        child: const Icon(Icons.edit,color: Colors.yellow,))),
                DataCell(
                    GestureDetector(
                      onTap: (){
                        showDeleteConfirmationDialog(context,item,context.read<DeleteCategoryCubit>());
                      },
                        child: const Icon(Icons.delete_forever,color: Colors.red,))),
              ]);
            }).toList();
          }).expand((row) => row).toList(),
        ),
      )
      );
  }
}

void showDeleteConfirmationDialog(BuildContext context, Category item, DeleteCategoryCubit deleteCategoryCubit) {

showDialog(context: context, builder: (BuildContext context){
  return AlertDialog(
    title:  const Text('Confirmation'),
    content:  const Text('Are you sure you want to delete this item?'),
    actions: [
      TextButton(onPressed: (){
        //Delete Action
       deleteCategoryCubit.deleteCategory(item.id);
        Navigator.pop(context);
      }, child:  const Text('Delete')),
      TextButton(onPressed: (){
        Navigator.pop(context);
      },
          child:  const Text('Cancel'))
    ],
  );
});
}

