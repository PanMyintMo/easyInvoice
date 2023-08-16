import 'package:dotted_border/dotted_border.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/DeliveryPart/FetchAllDeliveryName.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/ChangeOrderProductQty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../bloc/post/DeliveryPart/add_delivery_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CityPart/Cities.dart';
import '../../data/responsemodel/TownshipsPart/TownshipByCityIdResponse.dart';
class AddDeliveryWidget extends StatefulWidget {
  final bool isLoading;
  const AddDeliveryWidget({super.key, required this.isLoading});

  @override
  State<AddDeliveryWidget> createState() => _AddDeliveryWidgetState();
}

class _AddDeliveryWidgetState extends State<AddDeliveryWidget> {
  File? image;
  List<AllDeliveryName> deliveryCompanyName = [];
  List<City> cities =[];
  List<TownshipByCityIdData> townships = [];
  late String township_id;
  bool hasTownshipForSelectedCity = true;

  String? select_company; // Initialize select_company with null
  String? select_city;
  String? select_township;


  final formKey = GlobalKey<FormState>();
  final name=TextEditingController();
  final basicCost=TextEditingController();
  final waitingTime=TextEditingController();


  @override
  void initState() {
    super.initState();
    //for company name info
    fetchDeliveryCompanyName();
    fetchCityName();
  }
  void fetchDeliveryCompanyName() async {
    final deliveryCompanyName = await ApiService().fetchAllDeliveryCompanyName();
    setState(() {
      this.deliveryCompanyName = deliveryCompanyName;
      print('$deliveryCompanyName');
    });
  }
  void fetchCityName() async {
    final cities = await ApiHelper.fetchCityName();
    setState(() {
      this.cities = cities;
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
              validator: validateField,
              controller: name,
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
                onPressed: () {
                  if (formKey.currentState!.validate()){
                    formKey.currentState!.save();
                    context.read<AddDeliveryCubit>().addDelivery(AddDeliveryRequestModel(name: name.text, image: image!));
                  }

                  }, child: const Text('Add Delivery')),
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
                    ...deliveryCompanyName.map((deliveryCompanyName) {
                      return DropdownMenuItem<String>(
                        value: deliveryCompanyName.id.toString(),
                        child: Text(deliveryCompanyName.name),
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
                    ...cities.map((cities) {
                      return DropdownMenuItem<String>(
                        value: cities.id.toString(),
                        child: Text(cities.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      select_city = value; // Update the selected city
                      int cityId = int.parse(value!);
                      fetchTownshipByCityId(cityId);

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
          const SizedBox(height: 16,),
          Row(
            children: [
              const Expanded(child: Text('Choose Township')),
              Expanded(
                child: DropdownButton<String>(
                  value: hasTownshipForSelectedCity ? select_township : null,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select Township'),
                    ),
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
                        select_township = value;
                      });
                    },
                  hint: const Text('Select Township Name'),
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
          const SizedBox(height: 16,),
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    buildProductContainerText("Basic Cost"),
                    const SizedBox(
                      width: 10,
                    ),
                    buildProductContainerForm(
                      'Basic Cost',
                      TextInputType.number,
                      basicCost,
                      validateField,
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    buildProductContainerText("Waiting Time"),
                    const SizedBox(width: 10,),
                    buildProductContainerForm(
                      'Waiting Time',
                      TextInputType.name,
                      waitingTime,
                      validateField,
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                ElevatedButton(onPressed: (){

                  if (formKey.currentState!.validate()){
                    formKey.currentState!.save();

                    context.read<AddDeliveryCubit>().addDelivery(AddDeliveryRequestModel(name: name.text, image: image!));
                  }

                }, child: const Text("Add New"),)
              ],
            ),
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


}
