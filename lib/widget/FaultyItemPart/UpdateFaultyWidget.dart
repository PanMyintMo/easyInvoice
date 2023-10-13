import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit/FaultyPart/update_faulty_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/ConnectivityService.dart';
import '../../data/api/apiService.dart';
import '../../data/responseModel/GetAllPaganizationDataResponse.dart';
import '../../data/responseModel/common/ProductListItemResponse.dart';
import '../../dataRequestModel/ShopKeeperPart/EditRequestModel.dart';
import '../../screen/FaultyItemPart/FaultyItems.dart';

class UpdateFaultyWidget extends StatefulWidget {
  final int quantity;
  final int id;
  final String category_id;
  final String product_id;

  const UpdateFaultyWidget({super.key, required this.quantity, required this.id, required this.category_id, required this.product_id});

  @override
  State<UpdateFaultyWidget> createState() => _UpdateFaultyWidgetState();
}

class _UpdateFaultyWidgetState extends State<UpdateFaultyWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<PaganizationItem> categories = [];
  List<ProductListItem> products = [];
  String category_id = '';
  String? product_id;
  var quantity = TextEditingController();


  @override
  void initState() {
    super.initState();
    quantity = TextEditingController(text: widget.quantity.toString());
    _fetchData();
  }
  Future<void> _fetchData() async {
    await fetchCategoriesName();
    if (widget.category_id != '') {
      category_id = widget.category_id;
      await fetchProductsByCategory(int.parse(category_id));

      if (products
          .any((product) => product.id == int.parse(widget.product_id))) {
        product_id = widget.product_id;
      }
    }
  }
  Future<void> fetchCategoriesName() async {
    final categories = await ApiHelper.fetchCategoriesName();
    setState(() {
      this.categories = categories!;
    });
  }


  Future<void> fetchProductsByCategory(int id) async {
    final response = await ApiService(ConnectivityService()).fetchAllProductByCateId(id);
    setState(() {
      products = response;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                            context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                 const AllFaultyItemsScreen()));
                      },
                      child: const Text('All Faulty Item'),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text('Category'),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: category_id,
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category.id.toString(),
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          category_id = value;
                          product_id = null;
                          fetchProductsByCategory(int.parse(value!));                        });
                      },
                      hint: "Select Category",
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Product'),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: product_id,
                      items: products.map((product) {
                        return DropdownMenuItem(
                          value: product.id.toString(),
                          child: Text(product.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          product_id = value!;
                        });
                      },
                      hint: "Select Product",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Quantity'),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildProductContainerForm(
                      'Quantity',
                      TextInputType.number,
                      quantity,
                      validateField,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: validateAndSubmit,
                      child: const Text('Update Faulty'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      final requestModel = EditRequestModel(
        product_id: product_id!,
        quantity: quantity.text,
      );
      context
          .read<UpdateFaultyCubit>()
          .updateFaulty(widget.id,requestModel);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all the required fields.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
