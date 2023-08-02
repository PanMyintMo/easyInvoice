import 'package:easy_invoice/bloc/post/FaultyItemPart/add_request_faulty_item_cubit.dart';
import 'package:easy_invoice/dataRequestModel/FaultyItemPart/AddFaultyItemRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responsemodel/GetAllCategoryDetail.dart';
import '../../data/responsemodel/ProductByCategoryIdResponse.dart';
import '../../screen/FaultyItemPart/FaultyItems.dart';

class AddRequestFaultyItemWidget extends StatefulWidget {
  final bool isLoading;
  const AddRequestFaultyItemWidget({super.key, required this.isLoading});

  @override
  State<AddRequestFaultyItemWidget> createState() =>
      _AddRequestFaultyItemWidgetState();
}

class _AddRequestFaultyItemWidgetState
    extends State<AddRequestFaultyItemWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<CategoryItem> categories = [];
  List<ProductItem> products = [];
  String category_id = 'Select Category';
  String product_id = 'Select Product';
  var quantity = TextEditingController();

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
      child: Stack(
        children:
        [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)
                      =>
                          const AllFaultyItemsScreen()));
                    },
                        child: const Text('All FaultyItems', style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                  ),

                  const Text('Category', style: TextStyle(fontSize: 18,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold)),
                  const SizedBox(height: 18,),
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
                  const SizedBox(height: 18,),
                  const Text('Product', style: TextStyle(fontSize: 18,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold)),
                  const SizedBox(height: 18,),
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
                  const SizedBox(height: 18,),
                  const Text('Quantity', style: TextStyle(fontSize: 18,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold),),
                  const SizedBox(height: 18,),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          context.read<AddRequestFaultyItemCubit>()
                              .addRequestFaultyItem(AddFaultyItemRequest(
                              product_id: product_id,
                              quantity: quantity.text.toString()));
                        }
                      },
                      child: const Text('Add Faulty Item'),
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
}
