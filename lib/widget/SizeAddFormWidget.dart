import 'package:easy_invoice/bloc/post/add_category_cubit.dart';
import 'package:easy_invoice/bloc/post/add_size_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/dataRequestModel/AddSizeRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeAddFormWidget extends StatefulWidget {
  final bool isLoading; // Add the isLoading property
  final String message;

  const SizeAddFormWidget(
      {Key? key, required this.isLoading, required this.message})
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
    return BlocProvider(
      create: (context) => AddCategoryCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Size'),
        ),
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Column(
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
                            labelText: 'Add Size Name',
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

                  //show success or failure message base on the message
                  if (widget.message.isNotEmpty)
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
                    )
                ])
              ],
            ),
          ),
        ),
      ),
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
