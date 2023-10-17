import 'package:easy_invoice/bloc/post/CategoryPart/add_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_invoice/dataRequestModel/AddCategoryRequestModel.dart';

import '../common/FormValidator.dart';
import '../common/ThemeHelperUserClass.dart';

class AddCategoryFromWidget extends StatefulWidget {
  final bool isLoading; // Add the isLoading property

  const AddCategoryFromWidget(
      {Key? key, required this.isLoading,})
      : super(key: key);

  @override
  State<AddCategoryFromWidget> createState() => _AddCategoryFromWidgetState();
}

class _AddCategoryFromWidgetState extends State<AddCategoryFromWidget> {
  final TextEditingController name = TextEditingController();
  final TextEditingController slug = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.addListener(_updateSlugField);
  }

  @override
  void dispose() {
    name.dispose();
    slug.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: buildProductContainerForm('Category Name',
                  TextInputType.name, name, validateField),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: TextField(
                enabled: false,
                controller: slug,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Slug Name',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {
              final addCategoryCubit =
                  context.read<AddCategoryCubit>();
              // final token = widget.token; // Retrieve the bearer token from the widget
              //  final headers = {'Authorization': 'Bearer $token'};
              addCategoryCubit.addCategory(
                  AddCategoryRequestModel(name.text, slug.text));
            },
            child:  Text(
              'Add Category',
              style: TextStyle(color: Colors.green.shade900),
            )),
        if (widget.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );


  }

  void _updateSlugField() {
    final categoryName = name.text;
    final slugName = categoryName.toLowerCase().replaceAll(' ','-' );
    setState(() {
      slug.text = slugName;
    });
  }
}
