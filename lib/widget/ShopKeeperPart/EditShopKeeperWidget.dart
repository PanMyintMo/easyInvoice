import 'package:easy_invoice/bloc/post/ShopKeeperPart/update_shop_keeper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responsemodel/GetAllPagnitaionDataResponse.dart';
import '../../data/responsemodel/common/ProductListItemResponse.dart';
import '../../dataRequestModel/ShopKeeperPart/EditRequestModel.dart';
import '../../screen/shopkeeperPart/ShopKeeperAddScreen.dart';

class EditShopKeeperWidget extends StatefulWidget {
  final bool isLoading;
  final String quantity;
  final String shCategoryId;
  final String shProductId;
  final int id;

  const EditShopKeeperWidget({super.key,
    required this.isLoading,
    required this.quantity,
    required this.shCategoryId,
    required this.shProductId, required this.id});

  @override
  State<EditShopKeeperWidget> createState() => _EditShopKeeperWidgetState();
}

class _EditShopKeeperWidgetState extends State<EditShopKeeperWidget> {
  List<PaginationItem> categories = [];
  List<ProductListItem> products = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var quantity = TextEditingController();
  String category_id = '';
  String product_id = '';

  @override
  void initState() {
    super.initState();
    quantity = TextEditingController(text: widget.quantity.toString());
    _fetchData();
  }

  Future<void> _fetchData() async {
    await fetchCategoriesName();
    if (widget.shCategoryId != '') {
      category_id = widget.shCategoryId;
      await fetchProductsByCategory(int.parse(category_id));

      if (products
          .any((product) => product.id == int.parse(widget.shProductId))) {
        product_id = widget.shProductId;
      } else {
        product_id = '';
      }
    }
  }

  Future<void> fetchCategoriesName() async {
    final categories = await ApiHelper.fetchCategoriesName();
    setState(() {
      this.categories = categories;
    });
  }

  Future<void> fetchProductsByCategory(int id) async {
    final response = await ApiService().fetchAllProductByCateId(id);
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
                                const ShopKeeperScreen()));
                      },
                      child: const Text('All ShopKeeper'),
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
                          ...categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category.id.toString(),
                              child: Text(category.name),
                            );
                          }).toList(),
                        ],
                        onChanged: (value) async {
                          await fetchProductsByCategory(int.parse(value!));
                          setState(() {
                            category_id = value;
                            product_id = ''; // Reset product_id
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
                  const Text('Product'),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: chooseItemIdForm(
                      DropdownButton<String>(
                        value: product_id.isNotEmpty ? product_id : null,
                        items: [
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
                        hint: const Text('Select Product'),
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
                      child: const Text('Update ShopKeeper'),
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
        product_id: product_id,
        quantity: quantity.text,
      );
      context
          .read<UpdateShopKeeperCubit>()
          .updateShopKeeper(requestModel, widget.id);
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
