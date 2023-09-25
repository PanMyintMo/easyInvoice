import 'package:easy_invoice/bloc/post/FaultyItemPart/add_request_faulty_item_cubit.dart';
import 'package:easy_invoice/dataRequestModel/FaultyItemPart/AddFaultyItemRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responsemodel/GetAllPagnitaionDataResponse.dart';
import '../../data/responsemodel/common/ProductListItemResponse.dart';
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
  List<PaginationItem> categories = [];
  List<ProductListItem> products = [];
  String? category_id;
  String? product_id;
  var quantity = TextEditingController();

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
    final response = await ApiService().fetchAllProductByCateId(id);
    setState(() {
      products = response;
      product_id= null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AllFaultyItemsScreen()));
                        },
                        child: const Text('All FaultyItems',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))),
                  ),
                  const Text('Category',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 18,
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
                          fetchProductsByCategory(int.parse(category_id!));
                        });
                      },
                      hint: "Select Category",
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text('Product',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 18,
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
                      hint: "Select Product",
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'Quantity',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 18,
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          context
                              .read<AddRequestFaultyItemCubit>()
                              .addRequestFaultyItem(AddFaultyItemRequest(
                                  product_id: product_id!,
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
