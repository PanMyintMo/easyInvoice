import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_invoice/common/FormValidator.dart';
import 'package:easy_invoice/common/ThemeHelperUserClass.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';
import '../../bloc/post/ShopKeeperPart/add_request_product_shop_keeper_cubit.dart';
import '../../data/responsemodel/common/ProductListItemResponse.dart';
import '../../screen/shopkeeperPart/ShopKeeperAddScreen.dart';

class RequestShopKeeperWidget extends StatefulWidget {
  final bool isLoading;
  const RequestShopKeeperWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<RequestShopKeeperWidget> createState() =>
      _RequestShopKeeperWidgetState();
}

class _RequestShopKeeperWidgetState extends State<RequestShopKeeperWidget> {
  List<CategoryItem> categories = [];
  List<ProductListItem> products = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var quantity = TextEditingController();

  String category_id = 'Select Category';
  String product_id = 'Select Product';

  @override
  void initState() {
    super.initState();
    fetchCategoriesName();
  }

  Future<void> fetchCategoriesName() async {
    final categories = await ApiHelper.fetchCategoriesName();
    setState(() {
      this.categories = categories;
    });
  }

  Future<void> fetchProductsByCategory(int id) async {
    try {
      final response = await ApiService().fetchAllProductByCateId(id);
      if (response.isNotEmpty) {
        setState(() {
          products = response;
          product_id = 'Select Product'; // Reset selected product
        });
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children:[
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopKeeperScreen()));
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
                  child: chooseItemIdForm(
                    DropdownButton<String>(
                      value: category_id,
                      items: [
                        const DropdownMenuItem<String>(
                          value: 'Select Category',
                          child: Text('Select Category'),
                        ),
                        ...categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: Text(category.name),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        if (value == 'Select Category') {
                          setState(() {
                            category_id = value!;
                            product_id = 'Select Product';
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content:
                                    const Text('You need to choose a category.'),
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
                        } else {
                          setState(() {
                            category_id = value!;
                          });
                          fetchProductsByCategory(int.parse(value!));
                        }
                      },
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
                  child: chooseItemIdForm(
                    DropdownButton<String>(
                      value: product_id,
                      items: [
                        const DropdownMenuItem<String>(
                          value: 'Select Product',
                          child: Text('Select Product'),
                        ),
                        ...products.map((product) {
                          return DropdownMenuItem<String>(
                            value: product.id.toString(),
                            child: Text(product.name),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          product_id = value!;
                        });
                      },
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
        category_id: category_id,
        product_id: product_id,
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
