import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post/TownshipPart/add_township_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CityPart/Cities.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../dataRequestModel/TownshipPart/AddTownship.dart';
class AddNewTownshipWidget extends StatefulWidget {
  
  final bool isLoading;

  const AddNewTownshipWidget({super.key, required this.isLoading});

  @override
  State<AddNewTownshipWidget> createState() => _AddNewTownshipState();
}

class _AddNewTownshipState extends State<AddNewTownshipWidget> {
  List<City> cities=[];
  List<Country> countries = [];
  String? select_country;
  String? select_city;
  var name = ''; // Store the value of the name field in this variable

  @override
  void initState() {
    super.initState();
    fetchCountyName();
    fetchCityName();
  }

  void fetchCityName() async {
    final city = await ApiHelper.fetchCityName();
    setState(() {
      this.cities = city;
    });
  }


  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    setState(() {
      this.countries = country!;
    });
  }
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: chooseItemIdForm(
                  DropdownButton<String>(
                    hint: const Text("Select Country"),
                    value: select_country,
                    items: [
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
                    hint: const Text("Select City"),
                    value: select_city,
                    items: [

                      ...cities.map((city) {
                        return DropdownMenuItem<String>(
                          value: city.id.toString(),
                          child: Text(city.name),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        select_city = value; // Update the selected city
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
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Township name cannot be empty';
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
                    labelText: 'Township Name',
                    hintText: 'Township Name',
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<AddTownshipCubit>().addTownship(
                      AddTownship(name: name,country_id: select_country.toString(),city_id: select_city.toString()),
                    );
                  }
                },
                child: const Text('Add New Township'),
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
