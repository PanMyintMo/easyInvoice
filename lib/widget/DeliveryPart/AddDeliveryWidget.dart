import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/DeliveryPart/deli_company_info_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responseModel/CityPart/Cities.dart';
import '../../data/responseModel/DeliveryPart/FetchAllDeliveryName.dart';
import '../../data/responseModel/TownshipsPart/TownshipByCityIdResponse.dart';
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyInfoRequestModel.dart';

class AddDeliveryWidget extends StatefulWidget {
  final bool isLoading;

  const AddDeliveryWidget({super.key, required this.isLoading});

  @override
  State<AddDeliveryWidget> createState() => _AddDeliveryWidgetState();
}

class _AddDeliveryWidgetState extends State<AddDeliveryWidget> {
  String? select_company;
  List<AllDeliveryName> deliveryCompanyName = [];
  List<City> cities = [];
  String? select_city;
  final basicCost = TextEditingController();
  final waitingTime = TextEditingController();

  String? select_township;
  List<TownshipByCityIdData> townships = [];

  @override
  void initState() {
    super.initState();
    fetchDeliveryCompanyName();
    fetchCityName();
  }

  void fetchCityName() async {
    final cities = await ApiHelper.fetchCityName();
    setState(() {
      this.cities = cities;
    });
  }

  void fetchDeliveryCompanyName() async {
    final deliveryCompanyName =
        await ApiService().fetchAllDeliveryCompanyName();
    setState(() {
      this.deliveryCompanyName = deliveryCompanyName;

    });
  }

    void fetchTownshipByCityId(int id) async {

    final response = await ApiService().fetchAllTownshipByCityId(id);
      setState(() {
        townships = response;
        if (response.isNotEmpty) {
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProductContainerText("Choose Delivery"),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_company,
                      items: deliveryCompanyName.map((company) {
                        return DropdownMenuItem(
                          value: company.id.toString(),
                          child: Text(company.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_company = value!;
                        });
                      },
                      hint: "Choose Company",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildProductContainerText("Choose City"),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_city,
                      items: cities.map((city) {
                        return DropdownMenuItem(
                          value: city.id.toString(),
                          child: Text(city.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_city = value!;
                          fetchTownshipByCityId(int.parse(select_city!));
                        });
                      },
                      hint: "Choose City",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildProductContainerText("Choose Township"),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_township,
                      items: townships.map((township) {
                        return DropdownMenuItem(
                          value: township.id.toString(),
                          child: Text(township.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_township = value!;
                        });
                      },
                      hint: "Choose Township",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildProductContainerText("Basic Cost"),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    child: buildProductContainerForm(
                      'Basic cost',
                      TextInputType.number,
                      basicCost,
                      validateField,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildProductContainerText("Waiting Time"),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: buildProductContainerForm(
                      'waiting',
                      TextInputType.text,
                      waitingTime,
                      validateField,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      style: ThemeHelperUserRole().buttonStyle(),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<DeliCompanyInfoCubit>().deliCompanyInfo(
                           AddDeliCompanyInfoRequest(company_id: select_company.toString(),
                               city_id: select_city.toString(), township_id: select_township.toString(),
                               basic_cost: basicCost.text.toString(), waiting_time: waitingTime.text.toString())
                          );
                        }
                      },
                      child: const Text('Add Delivery'),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        if (widget.isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
