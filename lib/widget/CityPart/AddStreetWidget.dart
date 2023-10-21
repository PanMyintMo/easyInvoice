import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_invoice/bloc/post/CityPart/add_street_cubit.dart';
import 'package:easy_invoice/dataRequestModel/CityPart/AddStreetRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/ConnectivityService.dart';
import '../../data/api/apiService.dart';
import '../../data/responseModel/CityPart/FetchCityByCountryId.dart';

import '../../data/responseModel/CityPart/WardByTownshipResponse.dart';
import '../../data/responseModel/CountryPart/CountryResponse.dart';
import '../../data/responseModel/TownshipsPart/TownshipByCityIdResponse.dart';

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

  int? countryId;
  int? cityId;
  int? townshipId;

  List<Country> countries = [];
  List<WardByTownshipData> wards = [];
  List<CityByCountryIdData> cities = [];
  List<TownshipByCityIdData> townships = [];
  final connectivityService = ConnectivityService();

  final name = TextEditingController();

  Future<void> fetchCountries() async {
    final countries = await ApiHelper.fetchCountryName();
    setState(() {
      this.countries = countries!;
    });
  }

  Future<void> fetchWardByTownshipId(int id) async {
    final wards = await ApiHelper.fetchWardByTownshipId(id);
    setState(() {
      this.wards = wards;
    });
  }

  void fetchCitiesByCountryId(int id) async {
    if(countryId != null){
      var connectivityResult = await connectivityService.checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        final response =
        await ApiService(ConnectivityService()).fetchAllCitiesByCountryId(id);
        setState(() {
          select_city = null;
          cities = response;
        });
      }
    }
  }

  void fetchTownshipByCityId(int id) async {
    if (cityId != null) {
      var connectivityResult = await connectivityService.checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        final response =
        await ApiService(ConnectivityService()).fetchAllTownshipByCityId(id);

        setState(() {
          select_township = null;
          townships = response;
        });
      }
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
          padding: const EdgeInsets.only(
              left: 30, right: 30, top: 50, bottom: 10),
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
                          value: country.id.toString(), child: Text(
                          country.name));
                    }).toList(),
                    onChanged: (value) async {
                      setState(() {
                        select_country = value!;
                        select_city = null;
                        select_township = null;
                        countryId = int.parse(value);
                      });
                      if (countryId != null) {
                        var connectivityResult =
                        await connectivityService.checkConnectivity();
                        if (connectivityResult == ConnectivityResult.none) {
                          // no internet connection
                        } else {
                          fetchCitiesByCountryId(countryId!);
                        }
                      }
                    },
                    hint: "Select Country Name",
                    context: context,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Choose City',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  buildDropdown(
                    value: select_city,
                    items: cities.map((city) {
                      return DropdownMenuItem(
                          value: city.id.toString(), child: Text(city.name));
                    }).toList(),
                    onChanged: (value) async {
                      setState(() {
                        select_city = value!; //
                        select_township = null;
                        select_ward = null; // Update the selected city
                        cityId = int.parse(value);
                      });
                      fetchTownshipByCityId(cityId!);
                    },
                    hint: "Select City Name",
                    context: context,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Choose Township',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  buildDropdown(
                    value: select_township,
                    items: townships.map((township) {
                      return DropdownMenuItem(
                          value: township.id.toString(),
                          child: Text(township.name));
                    }).toList(),
                    onChanged: (value) async {
                      setState(() {
                        select_township = value!;
                        select_ward = null;
                        townshipId = int.parse(value);
                      });

                      if (townshipId != null) {
                        var connectivityResult =
                        await connectivityService.checkConnectivity();
                        if (connectivityResult == ConnectivityResult.none) {
                          // no internet connection
                        } else {
                          fetchWardByTownshipId(townshipId!);
                        }
                      }
                    },
                    hint: "Select Township Name",
                    context: context,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Choose Ward',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  buildDropdown(
                    value: select_ward,
                    items: wards.map((ward) {
                      return DropdownMenuItem(
                          value: ward.id.toString(),
                          child: Text(
                            ward.ward_name,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        select_ward = value!;
                      });
                    },
                    hint: "Select Ward Name",
                    context: context,
                  ),
                  const Text('Name',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
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
