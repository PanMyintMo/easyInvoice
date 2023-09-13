import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post/CityPart/add_city_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../dataRequestModel/CityPart/AddCity.dart';

class AddNewCityWidget extends StatefulWidget {
  final bool isLoading;

  const AddNewCityWidget({Key? key, required this.isLoading});

  @override
  State<AddNewCityWidget> createState() => _AddNewCityWidgetState();
}

class _AddNewCityWidgetState extends State<AddNewCityWidget> {
  List<Country> countries = [];
  String? selectedCountryId;
  TextEditingController nameController = TextEditingController(); // Use TextEditingController

  @override
  void initState() {
    super.initState();
    fetchCountryNames();
  }

  void fetchCountryNames() async {
    final countryList = await ApiHelper.fetchCountryName();
    setState(() {
      countries = countryList ?? [];
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField<String>(
                  hint: const Text("Select Country Name"),
                  value: selectedCountryId,
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
                      selectedCountryId = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Country',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: nameController, // Use the TextEditingController
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add City Name',
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<AddCityCubit>().addCity(
                      AddCity(name: nameController.text, country_id: selectedCountryId.toString()),
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
