import 'package:easy_invoice/bloc/edit/TownshipPart/edit_township_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ApiHelper.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responsemodel/CityPart/FetchCityByCountryId.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../dataRequestModel/TownshipPart/EditTownship.dart';

class EditTownshipWidget extends StatefulWidget {
  final bool isLoading;
  final String city_id;
  final int id;
  final String name;

  const EditTownshipWidget({
    Key? key,
    required this.isLoading,
    required this.city_id,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  State<EditTownshipWidget> createState() => _EditTownshipWidgetState();
}

class _EditTownshipWidgetState extends State<EditTownshipWidget> {
  List<CityByCountryIdData> cities = [];
  List<Country> countries = [];
  String? city_id;
  String? select_country;
  var name = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    fetchCountyName();
  }

  void fetchCitiesByCountryId(int id) async {
    try {
      final response = await ApiService().fetchAllCitiesByCountryId(id);
      if (response.isNotEmpty) {
        setState(() {
          cities = response;
          city_id = 'Select City'; // Reset city_id to default 'Select City'
        });
      }
    } catch (e) {}
  }

  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    setState(() {
      countries = country!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        Column(
          children: [
            Form(
              key: formKey,
              child: Container(
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
                    if (value == 'Select Country Name') {
                      setState(() {
                        select_country = value; // Update the selected country
                        city_id = 'Select City'; // Reset city_id when a country is selected
                      });
                    } else {
                      setState(() {
                        select_country = value;
                      });

                      fetchCitiesByCountryId(int.parse(value!));
                    }
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
                  value: city_id,
                  items: [
                    const DropdownMenuItem<String>(
                      value: 'Select City',
                      child: Text('Select City'),
                    ),
                    ...cities.map((city) {
                      return DropdownMenuItem<String>(
                        value: city.id.toString(),
                        child: Text(city.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      city_id = value; // Update the selected city_id
                    });
                  },
                  hint: const Text("Select City"),
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
                  context.read<EditTownshipCubit>().updateTownship(
                    widget.id,
                    EditTownship(city_id: city_id!.toString(), name: name.text),
                  );
                }
              },
              child: const Text('Update Township'),
            )
          ],
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
