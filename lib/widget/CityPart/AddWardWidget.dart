import 'package:easy_invoice/bloc/post/CityPart/add_ward_cubit.dart';
import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:easy_invoice/common/FormValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/ConnectivityService.dart';
import '../../data/api/apiService.dart';
import '../../data/responseModel/CityPart/FetchCityByCountryId.dart';
import '../../data/responseModel/CountryPart/CountryResponse.dart';
import '../../data/responseModel/TownshipsPart/TownshipByCityIdResponse.dart';
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
      final response = await ApiService(ConnectivityService()).fetchAllCitiesByCountryId(id);
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
      final response = await ApiService(ConnectivityService()).fetchAllTownshipByCityId(id);
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
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ListView(
            children: [
              const Text('Country Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              const SizedBox(height: 16,),

              buildDropdown(
                value: select_country,
                items: countries.map((country) {
                  return DropdownMenuItem(
                      value: country.id.toString(),
                      child: Text(country.name));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_country = value!;
                    int countryId = int.parse(value);
                    fetchCitiesByCountryId(countryId);
                  });
                },
                hint: "Select Country Name", context: context,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Choose City',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              const SizedBox(height: 16,),
              buildDropdown(
                value: select_city,
                items: cities.map((city) {
                  return DropdownMenuItem(
                      value: city.id.toString(),
                      child: Text(city.name));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_city = value ;
                    int cityId = int.parse(value);
                    fetchTownshipByCityId(cityId);
                  });
                },
                hint: "Select City Name", context: context,
              ),

              const SizedBox(
                height: 16,
              ),
              const Text('Choose Township',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              const SizedBox(height: 16,),
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
                hint: "Select Township Name", context: context,
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
        ),
        if(widget.isLoading)
          Container(
            color: Colors.blueAccent.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
