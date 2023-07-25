import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../common/ApiHelper.dart';
import '../../data/responsemodel/CityPart/Cities.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';

class AddDeliveryWidget extends StatefulWidget {
  const AddDeliveryWidget({super.key});

  @override
  State<AddDeliveryWidget> createState() => _AddDeliveryWidgetState();
}

class _AddDeliveryWidgetState extends State<AddDeliveryWidget> {
  File? image;
  List<City> city = [];
  List<Country> country =[];

  String? select_company; // Initialize select_company with null
  String? select_city;


  @override
  void initState() {
    super.initState();
    //for company name info
    fetchCityName();
    fetchCountyName();
  }
  void fetchCityName() async {
    final city = await ApiHelper.fetchCityName();
    setState(() {
      this.city = city;
    });
  }
  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    setState(() {
      this.country = country;
    });
  }
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
                onPressed: () {}, child: const Text('All Deliveries')),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Delivery Name',
                  hintText: 'Delivery Name'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
     const SizedBox(height: 10,),
          DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.grey,
            strokeWidth: 1,
            radius: const Radius.circular(10),
            dashPattern: const [4, 4],
            child: InkWell(
              onTap: () {
                pickImage();
              },
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Center(
                  child: buildImageWidget(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10,),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Add Delivery')),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Expanded(child: Text('Choose Delivery')),
              Expanded(
                child: DropdownButton<String>(
                  value: select_company,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select Company Name'),
                    ),
                    ...city.map((cities) {
                      return DropdownMenuItem<String>(
                        value: cities.id.toString(),
                        child: Text(cities.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      select_company = value; // Update the selected city
                    });
                  },
                  hint: const Text('Select Company Name'),
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
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Expanded(child: Text('Choose City')),
              Expanded(
                child: DropdownButton<String>(
                  value: select_city,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select City Name'),
                    ),
                    ...country.map((country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(country.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      select_city = value; // Update the selected city
                    });
                  },
                  hint: const Text('Select City Name'),
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
            ],
          ),
        ],
      ),
    );
  }
  Widget buildImageWidget() {
    if (image != null) {
      return Image.file(
        image!,
        fit: BoxFit.cover,
      );
    } else {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload,
            size: 40,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'Upload Image',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      );
    }
  }

  void validateAndSubmit() async {}
}
