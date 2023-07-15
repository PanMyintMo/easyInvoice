import 'dart:core';

import 'package:easy_invoice/data/responsemodel/GetAllProductResponse.dart';
import 'package:flutter/material.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responsemodel/GetAllCategoryDetail.dart';

class RequestShopKeeperWidget extends StatefulWidget {
  const RequestShopKeeperWidget({Key? key}) : super(key: key);

  @override
  State<RequestShopKeeperWidget> createState() =>
      _RequestShopKeeperWidgetState();
}

class _RequestShopKeeperWidgetState extends State<RequestShopKeeperWidget> {
  List<CategoryItem> categories = [];
  List<ProductListItem> products = [];

  String selectedValue = 'Select Category';
  String selectProduct = 'Select Product';

  @override
  void initState() {
    super.initState();
    fetchCategoriesName();
  }

  Future<void> fetchCategoriesName() async {
    try {
      final response = await ApiService().getAllCategories();
      if (response.data.data.isNotEmpty) {
        setState(() {
          categories = response.data.data;
        });
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      final response = await ApiService().fetchAllProducts();
      if (response.data.data.isNotEmpty) {
        setState(() {
          products = response.data.data
              .where((product) => product.category_id.toString() == categoryId)
              .toList();
        });
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Expanded(child: Text('ShopKeeper')),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('All Requesting Products'),
                ),
              ),
            ],
          ),
        ),
        const Text('Category'),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: chooseItemIdForm(
            DropdownButton<String>(
              value: selectedValue,
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
                    selectedValue = value!;
                    selectProduct = 'Select Product';
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('You need to choose a category.'),
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
                    selectedValue = value!;
                    selectProduct = 'Select Product';
                  });
                  fetchProductsByCategory(value!);
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
        const Text('Product'),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: chooseItemIdForm(
            DropdownButton<String>(
              value: selectProduct,
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
                if (value == 'Select Product') {
                  setState(() {
                    selectProduct = value!;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('You need to choose a product.'),
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
                    selectProduct = value!;
                  });
                }
              },
              hint: const Text('Choose One'),
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
        const Text('Quality'),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: chooseItemIdForm(
            DropdownButton<String>(
              items: [],
              onChanged: (value) {
                setState(() {});
              },
              hint: const Text('Choose One'),
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
        ElevatedButton(
          onPressed: () {},
          child: const Text('Add ShopKeeper'),
        ),
      ],
    );
  }
}
