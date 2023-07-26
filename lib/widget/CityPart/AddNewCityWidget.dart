import 'package:easy_invoice/common/ThemeHelperUserClass.dart';
import 'package:easy_invoice/dataRequestModel/CityPart/AddCity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post/CityPart/add_city_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';

class AddNewCityWidget extends StatefulWidget {
  final bool isLoading;
  const AddNewCityWidget({super.key, required this.isLoading});

  @override
  State<AddNewCityWidget> createState() => _AddNewCityWidgetState();
}

class _AddNewCityWidgetState extends State<AddNewCityWidget> {
  List<Country> countries = [];
  String? select_country;
  var name = ''; // Store the value of the name field in this variable

  @override
  void initState() {
    super.initState();
    fetchCountyName();
  }

  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    setState(() {
      this.countries = country;
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
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'City name cannot be empty';
                    }
                    return null;
                  },
                  initialValue: name, // Set the initial value from the variable
                  onChanged: (value) {
                    setState(() {
                      name = value; // Update the name variable when the field changes
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'City Name',
                    hintText: 'City Name',
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: chooseItemIdForm(
                  DropdownButton<String>(
                    value: select_country,
                    items: [
                      const DropdownMenuItem(
                        value: null, // Set initial value to null
                        child: Text('Select Country Name'),
                      ),
                      ...countries.map((country) {
                        return DropdownMenuItem<String>(
                          value: country.id.toString(),
                          child: Text(country.name),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        select_country = value; // Update the selected city
                      });
                    },
                    hint: const Text('Select Company Name'),
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
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<AddCityCubit>().addCity(
                      AddCity(name: name, country_id: select_country.toString()),
                    );
                  }
                },
                child: const Text('Add New City'),
              ),
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

