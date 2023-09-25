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
         /*   Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: buildDropdown(
                value: select_country!,
                hint: "Select City",
                items: countries,
                onChanged: (value) {
                  setState(() {
                    select_country = value;
                    city_id = 'Select City';
                    fetchCitiesByCountryId(int.parse(value!));
                  });
                },
              ),

            ),*/
         /*   Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: buildDropdown(
                value: city_id!,
                hint: "Select City",
                items: cities,
                onChanged: (value) {
                  setState(() {
                    city_id = value;
                  });
                },
              ),

            ),*/
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
