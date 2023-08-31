import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/ShopKeeperPart/add_request_product_shop_keeper_cubit.dart';
import '../../common/ApiHelper.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/apiService.dart';
import '../../data/responsemodel/GetAllCategoryDetail.dart';
import '../../data/responsemodel/common/ProductListItemResponse.dart';
import '../../dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';
import '../../screen/shopkeeperPart/ShopKeeperAddScreen.dart';

class EditShopKeeperWidget extends StatefulWidget {
  final bool isLoading;
  final String quantity;
  final String shCategoryId;
  final String shProductId;

  const EditShopKeeperWidget(
      {super.key, required this.isLoading, required this.quantity, required this.shCategoryId, required this.shProductId});

  @override
  State<EditShopKeeperWidget> createState() => _EditShopKeeperWidgetState();
}

class _EditShopKeeperWidgetState extends State<EditShopKeeperWidget> {
  List<CategoryItem> categories = [];
  List<ProductListItem> products = [];


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var quantity = TextEditingController();
  String category_id = 'Select Category';
  String product_id='Select Product';


  @override
  void initState() {
    super.initState();
    quantity = TextEditingController(text: widget.quantity.toString());
    fetchCategoriesName();


    if (widget.shCategoryId != 'Select Category') {
      category_id = widget.shCategoryId;
      fetchProductsByCategory(int.parse(category_id));
    }


    if(widget.shProductId != 'Select Product'){
      product_id = widget.shProductId;
      final selectedProductIndex = products.indexWhere((product) => product.id == product_id);
      if(selectedProductIndex >= 0 ){
        product_id = products[selectedProductIndex].id.toString();
      }
    } else {
      product_id = 'Select Product';
    }

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

        });
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
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
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ShopKeeperScreen()));
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
                    onChanged: (value) {
                      setState(() {
                        category_id = value!;
                        product_id = 'Select Product';
                      });
                      fetchProductsByCategory(int.parse(value!));
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
                          value:  product_id != 'Select Product' ? product_id : null,
                          items: [
                            const DropdownMenuItem<String>(
                              value:  null,
                              child: Text('Select Product'),
                            ),
                          ...products.map((product) {
                  return DropdownMenuItem<String>(
                  value: product.id.toString(),
                  child: Text(product.name),
                  );
                  }).toList(),

                  ],
                  onChanged: (value)
              {
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
      final requestModel = ShopKeeperRequestModel(
        category_id: category_id,
        product_id: product_id,
        quantity: quantity.text,
      );
      context.read<AddRequestProductShopKeeperCubit>()
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
