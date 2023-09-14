import 'package:easy_invoice/dataRequestModel/CityPart/EditCity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit/CityPart/edit_city_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';

class EditCityWidget extends StatefulWidget {
  final bool isLoading;
  final String name;
  final String country_id;
  final int id;

  const EditCityWidget({
    Key? key,
    required this.isLoading,
    required this.name,
    required this.country_id,
    required this.id,
  }) : super(key: key);

  @override
  State<EditCityWidget> createState() => _EditCityWidgetState();
}

class _EditCityWidgetState extends State<EditCityWidget> {
  List<Country> countries = [];
  var country_id;
  var name = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    fetchCountyName();
  }

  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    setState(() {
      this.countries = country!;
      country_id = widget.country_id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: chooseItemIdForm(
                  DropdownButton<String>(
                    value: country_id.toString(),
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(country.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        country_id = value ; // Update the selected country_id
                      });
                    },
                    hint: const Text('Select Country Name'),
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'City Name',
                    hintText: 'City Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'City name cannot be empty';
                    }
                    return null;
                  },
                ),
              ),

              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<EditCityCubit>().updateCity(
                      widget.id,
                      EditCity(country_id: country_id!.toString(), name: name.text),
                    );
                  }
                },
                child: const Text('Update City'),
              )
            ],
          ),
        ),
        if (widget.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
