import 'package:easy_invoice/bloc/edit/CountryPart/edit_country_cubit.dart';
import 'package:easy_invoice/dataRequestModel/CountryPart/EditCountry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCountryWidget extends StatefulWidget {
  final bool isLoading;
  final String name;
  final int id;
  const EditCountryWidget({super.key, required this.isLoading, required this.name, required this.id});

  @override
  State<EditCountryWidget> createState() => _EditCountryWidgetState();
}

class _EditCountryWidgetState extends State<EditCountryWidget> {
  late TextEditingController name;
  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Country Name',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  final editCountryCubit = context.read<EditCountryCubit>();
                  editCountryCubit.updateCountry(widget.id,EditCountry(name: name.text));
                },
                child: const Text(
                  'Update Country',
                  style: TextStyle(color: Colors.green),
                )),
          ),
          if (widget.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      );

  }
}
