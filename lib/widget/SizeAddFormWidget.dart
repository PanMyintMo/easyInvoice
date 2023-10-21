import 'package:easy_invoice/bloc/post/add_size_cubit.dart';
import 'package:easy_invoice/dataRequestModel/AddSizeRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/FormValidator.dart';
import '../common/ThemeHelperUserClass.dart';

class SizeAddFormWidget extends StatefulWidget {
  final bool isLoading; // Add the isLoading property


  const SizeAddFormWidget(
      {Key? key, required this.isLoading})
      : super(key: key);

  @override
  State<SizeAddFormWidget> createState() => _SizeAddFormWidgetState();
}

class _SizeAddFormWidgetState extends State<SizeAddFormWidget> {
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: buildProductContainerForm('Size Name',
                    TextInputType.name, name, validateField),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  controller: slug,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Slug Name',
                    enabled: false,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Stack(children: [
          Positioned(
            child: Center(
              child: TextButton(
                  onPressed: () {
                    final addSizeCubit =
                        context.read<AddSizeCubit>();
                    // final token = widget.token; // Retrieve the bearer token from the widget
                    //  final headers = {'Authorization': 'Bearer $token'};
                    addSizeCubit.addSize(
                        AddSizeRequestModel(name.text, slug.text));
                  },
                  child: const Text(
                    'Add Size',
                    style: TextStyle(color: Colors.green),
                  )),
            ),
          ),
          if (widget.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ])
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
