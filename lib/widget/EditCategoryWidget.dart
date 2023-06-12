import 'package:easy_invoice/bloc/edit/edit_category_cubit.dart';
import 'package:easy_invoice/dataModel/EditCategoryModel.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCateWidget extends StatefulWidget {
  final String name;
  final String slug;
  final int id;

  const EditCateWidget({
    required this.name,
    required this.slug,
    Key? key, required this.id,
  }) : super(key: key);

  @override
  State<EditCateWidget> createState() => _EditCateWidgetState();
}

class _EditCateWidgetState extends State<EditCateWidget> {


  late TextEditingController name;
  late TextEditingController slug;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    slug = TextEditingController(text: widget.slug);
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
    return BlocProvider(
      create: (context) => EditCategoryCubit(getIt.call()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Category Name',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: slug,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Slug Name',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(children: [
            Positioned(
              child: Center(
                child: TextButton(
                    onPressed: () {
                      final editCateCubit =
                      context.read<EditCategoryCubit>();
                      editCateCubit.editCategory(EditCategory(name: name.text,slug: slug.text),widget.id);
                    },
                    child: const Text(
                      'Update Category',
                      style: TextStyle(color: Colors.green),
                    )),
              ),
            ),
            // if (widget.isLoading)
            //   const Center(
            //     child: CircularProgressIndicator(),
            //   ),

            //show success or failure message base on the message
            /* if (widget.message.isNotEmpty)
            Positioned(
              left: MediaQuery.of(context).size.height * 0.5 + 60,
              child: Text(
                widget.message,
                style: TextStyle(
                    fontSize: 18,
                    color: widget.message.startsWith('Success')
                        ? Colors.green
                        : Colors.red),
              ),
            )*/
          ])
        ],
      ),
    );
  }

  void _updateSlugField() {
    final updateCateName = name.text;
    final updateSlugName = updateCateName.toLowerCase().replaceAll(' ', '-');

    setState(() {
      slug.text = updateSlugName;
    });
  }
}
