import 'package:easy_invoice/data/api/apiService.dart';
import 'package:flutter/material.dart';
import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CityPart/FetchCityByCountryId.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../data/responsemodel/TownshipsPart/TownshipByCityIdResponse.dart';
import '../../data/responsemodel/common/WardResponse.dart';

class EditWardWidget extends StatefulWidget {
  final bool isLoading;
  final String ward_name;
  final String township_id;
  final List<Ward> ward;

  const EditWardWidget({
    Key? key,
    required this.isLoading,
    required this.ward_name,
    required this.township_id,
    required this.ward,
  }) : super(key: key);

  @override
  State<EditWardWidget> createState() => _EditWardWidgetState();
}

class _EditWardWidgetState extends State<EditWardWidget> {
  TextEditingController wardNameController = TextEditingController();
  String? countryId;
  String? cityId;
  String? townshipId;

  List<Country> countries = [];
  List<CityByCountryIdData> cities = [];
  List<TownshipByCityIdData> townships = [];

  @override
  void initState() {
    super.initState();
    wardNameController.text = widget.ward_name;
    initializeDropdownValues();
  }

  void initializeDropdownValues() async {
    final fetchCountries = await ApiHelper.fetchCountryName();
    if (fetchCountries != null && fetchCountries.isNotEmpty) {
      setState(() {
        countries = fetchCountries;
        final ward = widget.ward.firstWhere(
              (ward) => ward.township_id == int.parse(widget.township_id),
          orElse: () => Ward(
            id: 0,
            township_id: 0,
            ward_name: '',
            created_at: '',
            updated_at: '',
            township: Townships(
              id: 0,
              city_id: 0,
              name: '',
              created_at: '',
              updated_at: '',
              cities: Cities(
                id: 0,
                country_id: 0,
                name: '',
                created_at: '',
                updated_at: '',
              ),
            ),
          ),
        );
        countryId = ward.township.cities.country_id.toString();
        fetchCitiesByCountryId(int.parse(countryId!));
      });
    }
  }

  void fetchCitiesByCountryId(int id) async {
    final fetchCities = await ApiService().fetchAllCitiesByCountryId(id);
    if (fetchCities.isNotEmpty) {
      setState(() {
        cities = fetchCities;
        final ward = widget.ward.firstWhere(
              (ward) => ward.township_id == int.parse(widget.township_id),
          orElse: () => Ward(
            id: 0,
            township_id: 0,
            ward_name: '',
            created_at: '',
            updated_at: '',
            township: Townships(
              id: 0,
              city_id: 0,
              name: '',
              created_at: '',
              updated_at: '',
              cities: Cities(
                id: 0,
                country_id: id, // Assuming the country_id should be set to the provided 'id'
                name: '',
                created_at: '',
                updated_at: '',
              ),
            ),
          ),
        );
        cityId = ward.township.cities.id.toString();
        fetchTownshipsByCityId(int.parse(cityId!));
      });
    }
  }


  void fetchTownshipsByCityId(int id) async {
    final fetchTownship = await ApiService().fetchAllTownshipByCityId(id);
    if (fetchTownship.isNotEmpty) {
      setState(() {
        townships = fetchTownship;
        townshipId = widget.township_id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProductContainerText("Country Name"),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: buildDropdown(
                    value: countryId,
                    items: countries.map((country) {
                      return DropdownMenuItem(
                        value: country.id.toString(),
                        child: Text(country.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        countryId = value;
                        cityId = null;
                        townshipId = null;
                        fetchCitiesByCountryId(int.parse(countryId!));
                      });
                    },
                    hint: "Select Country Name",
                  ),
                ),
                buildProductContainerText("City Name"),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: buildDropdown(
                    value: cityId,
                    items: cities.map((city) {
                      return DropdownMenuItem(
                        value: city.id.toString(),
                        child: Text(city.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        cityId = value;
                        townshipId = null;
                        fetchTownshipsByCityId(int.parse(cityId!));
                      });
                    },
                    hint: "Select City Name",
                  ),
                ),
                buildProductContainerText("Township Name"),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: buildDropdown(
                    value: townshipId,
                    items: townships.map((township) {
                      return DropdownMenuItem(
                        value: township.id.toString(),
                        child: Text(township.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        townshipId = value;
                      });
                    },
                    hint: "Select Township Name",
                  ),
                ),
                buildProductContainerText("Name"),
                const SizedBox(
                  height: 16,
                ),
                buildProductContainerForm(
                  'Ward',
                  TextInputType.text,
                  wardNameController,
                  FormValidator.validateName,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Update Ward"),
                ),
              ],
            ),
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
