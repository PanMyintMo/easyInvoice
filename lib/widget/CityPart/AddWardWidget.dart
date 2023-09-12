import 'package:easy_invoice/bloc/post/CityPart/add_ward_cubit.dart';
import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:easy_invoice/common/FormValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responsemodel/CityPart/FetchCityByCountryId.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../data/responsemodel/TownshipsPart/TownshipByCityIdResponse.dart';
import '../../dataRequestModel/CityPart/AddWardRequestModel.dart';

class AddWardWidget extends StatefulWidget {
  final bool isLoading;

  const AddWardWidget({super.key, required this.isLoading});

  @override
  State<AddWardWidget> createState() => _AddWardWidgetState();
}

class _AddWardWidgetState extends State<AddWardWidget> {
  String? select_country;
  String? select_city;
  String? select_township;
  String city_id = '';
  String township_id = '';
  List<Country> countries = [];
  List<CityByCountryIdData> cities = [];
  List<TownshipByCityIdData> townships = [];
  bool hasCitiesForSelectedCountry = true;
  bool hasTownshipForSelectedCity = true;
  final name = TextEditingController();

  Future<void> fetchCountries() async {
    final countries = await ApiHelper.fetchCountryName();
    setState(() {
      this.countries = countries!;
    });
  }

  void fetchCitiesByCountryId(int id) async {
    try {
      final response = await ApiService().fetchAllCitiesByCountryId(id);
      setState(() {
        cities = response;
        if (response.isNotEmpty) {
          city_id = 'Select City'; // Reset city_id to default 'Select City'
          hasCitiesForSelectedCountry = true;
        } else {
          hasCitiesForSelectedCountry = false;
        }
      });
    } catch (e) {
      setState(() {
        cities = [];
        hasCitiesForSelectedCountry = false;
      });
    }
  }

  void fetchTownshipByCityId(int id) async {
    try {
      final response = await ApiService().fetchAllTownshipByCityId(id);
      setState(() {
        townships = response;
        if (response.isNotEmpty) {
          township_id =
              'Select Township'; // Reset city_id to default 'Select City'
          hasTownshipForSelectedCity = true;
        } else {
          hasTownshipForSelectedCity = false;
        }
      });
    } catch (e) {
      setState(() {
        townships = [];
        hasTownshipForSelectedCity = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30,right: 30,top: 50,bottom: 10),
      child: Stack(
        children: [
          ListView(

            children: [
              const Text('Country Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                hint: const Text('Select Country Name'),
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
                    select_country = value!; // Update the selected country
                    int countryId = int.parse(value);
                    fetchCitiesByCountryId(countryId);
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
              const SizedBox(
                height: 10,
              ),
              const Text('Choose City',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                hint: const Text('Select City Name'),
                value: select_city,
                items: [
                  ...cities.map((cities) {
                    return DropdownMenuItem<String>(
                      value: cities.id.toString(),
                      child: Text(cities.name),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    select_city = value!; // Update the selected city
                    int cityId = int.parse(value);
                    fetchTownshipByCityId(cityId);
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
              const SizedBox(
                height: 16,
              ),
              const Text('Choose Township',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                hint: const Text('Select Township Name'),
                value: hasTownshipForSelectedCity ? select_township : null,
                items: [
                  if (hasTownshipForSelectedCity)
                    ...townships.map((township) {
                      return DropdownMenuItem<String>(
                        value: township.id.toString(),
                        child: Text(township.name),
                      );
                    }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    select_township = value!;
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
              const SizedBox(
                height: 16,
              ),
              const Text('Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 16,
              ),
              buildProductContainerForm(
                'Name ',
                TextInputType.name,
                name,
                validateField,
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      context.read<AddWardCubit>().addWard(
                          AddWardRequestModel(state_id: select_township.toString(), ward_name: name.text.toString()));
                    },
                    child: const Text("Add Ward")),
              )
            ],
          ),
          if(widget.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
