import 'package:easy_invoice/bloc/post/DeliveryPart/update_delivery_cubit.dart';
import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/UpdateDeliveryRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responseModel/CityPart/Cities.dart';
import '../../data/responseModel/DeliveryPart/FetchAllDeliveryName.dart';
import '../../data/responseModel/TownshipsPart/TownshipByCityIdResponse.dart';

class UpdateDeliveryWidget extends StatefulWidget {
  final bool isLoading;
  final int id;
  final String city_id;
  final String township_id;
  final String basic_cost;
  final String waiting_time;
  final String company_id;

  const UpdateDeliveryWidget(
      {super.key,
      required this.isLoading,
      required this.id,
      required this.city_id,
      required this.township_id,
      required this.basic_cost,
      required this.waiting_time,
        required this.company_id});

  @override
  State<UpdateDeliveryWidget> createState() => _UpdateDeliveryWidgetState();
}

class _UpdateDeliveryWidgetState extends State<UpdateDeliveryWidget> {

  List<AllDeliveryName> deliveryCompanyName = [];
  List<City> cities = [];

  List<TownshipByCityIdData> townships = [];
  var basicCost = TextEditingController();
  var waitingTime = TextEditingController();

  String? select_company;
  String? select_city;
  String? select_township;

  @override
  void initState() {
    super.initState();

    select_city = widget.city_id;
    select_township=widget.township_id;
    select_company=widget.company_id;

    basicCost = TextEditingController(text: widget.basic_cost);
    waitingTime = TextEditingController(text: widget.waiting_time);
    fetchCityName();
  }

  void fetchCityName() async {
    final response = await ApiHelper.fetchCityName();
    cities = response;
    setState(() {
      if (select_city != null) {
        fetchTownshipByCityId(int.parse(select_city!));
      }
    });
  }

  void fetchTownshipByCityId(int id) async {
    final response = await ApiService().fetchAllTownshipByCityId(id);
    townships = response;
    setState(() {
      if (select_township != null) {
        select_township = widget.township_id.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          select_township = null;
                        });
                        fetchTownshipByCityId(int.parse(value!));
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                      context.read<UpdateDeliveryCubit>().updateDeliveryById(
                          widget.id, UpdateDeliveryRequestModel(company_id: select_company!, township_id: select_township.toString(),
                          basic_cost: basicCost.text.toString(), waiting_time: waitingTime.text.toString()));
                        }
                      },
                      child: const Text('Update Delivery'),
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
