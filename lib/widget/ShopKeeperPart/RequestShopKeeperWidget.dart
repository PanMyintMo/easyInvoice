import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_invoice/common/FormValidator.dart';
import 'package:easy_invoice/common/ThemeHelperUserClass.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';
import '../../bloc/post/ShopKeeperPart/add_request_product_shop_keeper_cubit.dart';
import '../../data/api/ConnectivityService.dart';
import '../../data/responseModel/GetAllPaganizationDataResponse.dart';
import '../../data/responseModel/common/ProductListItemResponse.dart';
import '../../screen/shopkeeperPart/ShopKeeperAddScreen.dart';

class RequestShopKeeperWidget extends StatefulWidget {
  final bool isLoading;

  const RequestShopKeeperWidget({Key? key, required this.isLoading})
      : super(key: key);

  @override
  State<RequestShopKeeperWidget> createState() =>
      _RequestShopKeeperWidgetState();
}

class _RequestShopKeeperWidgetState extends State<RequestShopKeeperWidget> {
  List<PaganizationItem> categories = [];
  List<ProductListItem> products = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var quantity = TextEditingController();

  String? category_id;

  String? product_id;

  @override
  void initState() {
    super.initState();
    fetchCategoriesName();
  }

  Future<void> fetchCategoriesName() async {
    final categories = await ApiHelper.fetchCategoriesName();
    setState(() {
      this.categories = categories!;
    });
  }

  Future<void> fetchProductsByCategory(int id) async {
    final response = await ApiService(ConnectivityService()).fetchAllProductByCateId(id);
    if (response.isNotEmpty) {
      setState(() {
        products = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                                    const ShopKeeperScreen()));
                      },
                      child: const Text('All Requesting Products'),
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
                            child: Text(category.name));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          category_id = value!;
                          product_id=null;
                          fetchProductsByCategory(int.parse(value!));
                        });
                      },
                      hint: "Select Product", context: context,
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
                            child: Text(product.name));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          product_id = value!;
                        });
                      },
                      hint: "Select Product", context: context,
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
                      style: ThemeHelperUserRole().buttonStyle(),
                      onPressed: validateAndSubmit,
                      child: const Text('Add ShopKeeper'),
                    ),
                  ),
                ],
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
      ),
    );
  }

  void validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      final requestModel = ShopKeeperRequestModel(
        category_id: category_id!,
        product_id: product_id!,
        quantity: quantity.text,
      );
      context
          .read<AddRequestProductShopKeeperCubit>()
          .addRequestShopkeeperProduct(requestModel);
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
