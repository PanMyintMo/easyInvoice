import 'package:easy_invoice/bloc/post/CityPart/add_street_cubit.dart';
import 'package:easy_invoice/dataRequestModel/CityPart/AddStreetRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responseModel/CityPart/FetchCityByCountryId.dart';

import '../../data/responseModel/CountryPart/CountryResponse.dart';
import '../../data/responseModel/TownshipsPart/TownshipByCityIdResponse.dart';
import '../../data/responseModel/common/WardResponse.dart';

class AddStreetWidget extends StatefulWidget {
  final bool isLoading;

  const AddStreetWidget({super.key, required this.isLoading});

  @override
  State<AddStreetWidget> createState() => _AddStreetWidgetState();
}

class _AddStreetWidgetState extends State<AddStreetWidget> {
  String? select_country;
  String? select_city;
  String? select_township;
  String? select_ward;
  String city_id = '';
  String township_id = '';
  List<Country> countries = [];
  List<Ward> wards = [];
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

  Future<void> fetchWardName() async {
    final wards = await ApiHelper.fetchWardName();
    setState(() {
      this.wards = wards!;
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
    fetchWardName();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 10),
      child: Stack(
        children: [
          ListView(
            children: [
              const Text(
                'Country Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              buildDropdown(
                value: select_country,
                items: countries.map((country) {
                  return DropdownMenuItem(
                      value: country.id.toString(), child: Text(country.name));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_country = value!;
                    int countryId = int.parse(value);
                    fetchCitiesByCountryId(countryId);
                  });
                },
                hint: "Select Country Name",
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Choose City',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              buildDropdown(
                value: select_city,
                items: cities.map((city) {
                  return DropdownMenuItem(
                      value: city.id.toString(), child: Text(city.name));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_city = value!; // Update the selected city
                    int cityId = int.parse(value);
                    fetchTownshipByCityId(cityId);
                  });
                },
                hint: "Select City Name",
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Choose Township',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              buildDropdown(
                value: select_city,
                items: townships.map((township) {
                  return DropdownMenuItem(
                      value: township.id.toString(),
                      child: Text(township.name));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_township = value!;
                  });
                },
                hint: "Select Township Name",
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Choose Ward',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              buildDropdown(
                value: select_ward,
                items: wards.map((ward) {
                  return DropdownMenuItem(
                      value: ward.id.toString(),
                      child: Text(ward.ward_name));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_ward = value!;
                  });
                },
                hint: "Select Ward Name",
              ),

              const Text('Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                      context.read<AddStreetCubit>().addStreet(
                          AddStreetRequestModel(
                              ward_id: select_ward.toString(),
                              street_name: name.text.toString()));
                    },
                    child: const Text("Add Street")),
              )
            ],
          ),
          if (widget.isLoading)
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
