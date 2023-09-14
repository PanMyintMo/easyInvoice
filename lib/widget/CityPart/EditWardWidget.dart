import 'package:flutter/material.dart';

import '../../common/ApiHelper.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CityPart/Cities.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';

class EditWardWidget extends StatefulWidget {
  final bool isLoading;
  final String ward_name;
  final String state_id;

  const EditWardWidget({
    Key? key,
    required this.isLoading,
    required this.ward_name,
    required this.state_id,
  }) : super(key: key);

  @override
  State<EditWardWidget> createState() => _EditWardWidgetState();
}

class _EditWardWidgetState extends State<EditWardWidget> {
  List<Country> countries = [];
  List<int>? updateCountryId;
  List<int>? countryId;

  List<City> cities = [];
  var country_id;
  var ward_name = TextEditingController();

  @override
  void initState() {
    super.initState();
    ward_name = TextEditingController(text: widget.ward_name);

    fetchAllCity();
  }
  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    if (country!.isNotEmpty) {
      countryId = countries.map((country) => country.id).toList();
      if (countryId!.contains(updateCountryId)) {
        country_id = updateCountryId;
      } else if (countryId!.isNotEmpty) {
        country_id = countryId?.first;
      }
    }
  }

  void fetchAllCity() async {
    final city = await ApiHelper.fetchCityName();
    if (city.isNotEmpty) {
      updateCountryId = cities.map((city) => city.countryId).toList();
    }
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
                    hint: const Text('Select Country Name'),
                    value: country_id.toString(),
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(country.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        country_id = value; // Update the selected country_id
                      });
                    },
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
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: chooseItemIdForm(
                  DropdownButton<String>(
                    hint: const Text('Select City Name'),
                    value: country_id.toString(),
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(country.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        country_id = value; // Update the selected country_id
                      });
                    },
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
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: chooseItemIdForm(
                  DropdownButton<String>(
                    hint: const Text('Select Township Name'),
                    value: country_id.toString(),
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(country.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        country_id = value; // Update the selected country_id
                      });
                    },
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
                  controller: ward_name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Ward Name',
                    hintText: 'Ward Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ward name cannot be empty';
                    }
                    return null;
                  },
                ),
              ),

              // TextButton(
              //   onPressed: () {
              //     if (formKey.currentState!.validate()) {
              //       formKey.currentState!.save();
              //       context.read<EditCityCubit>().updateCity(
              //         widget.id,
              //         EditCity(country_id: country_id!.toString(), name: name.text),
              //       );
              //     }
              //   },
              //   child: const Text('Update City'),
              // )
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
