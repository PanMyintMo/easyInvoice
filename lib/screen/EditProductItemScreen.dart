import 'package:flutter/material.dart';
import '../common/ThemeHelperUserClass.dart';
import '../data/api/apiService.dart';
import '../data/responsemodel/GetAllCategoryDetail.dart';
import '../data/responsemodel/GetAllSizeResponse.dart';

class EditProductItemScreen extends StatefulWidget {
  final String name;
  final String slug;
  final String shortDescription;
  final String description;
  final String regularPrice;
  final String salePrice;
  final String buyingPrice;
  final String sku;
  final int quantity;
  final int categoryId;
  final int sizeId;

  const EditProductItemScreen({
    Key? key,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.description,
    required this.regularPrice,
    required this.salePrice,
    required this.buyingPrice,
    required this.sku,
    required this.quantity,
    required this.categoryId,
    required this.sizeId,
  }) : super(key: key);

  @override
  State<EditProductItemScreen> createState() => _EditProductItemScreenState();
}

class _EditProductItemScreenState extends State<EditProductItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController slug;
  late TextEditingController shortDescription;
  late TextEditingController quantity;
  late TextEditingController description;
  late TextEditingController regularPrice;
  late TextEditingController salePrice;
  late TextEditingController buyingPrice;
  late TextEditingController sku;
  late TextEditingController categoryId;
  late TextEditingController sizeId;

  List<CategoryItem> categories = [];
  List<SizeItems> sizes = [];

  @override
  void initState() {
    super.initState();

    name = TextEditingController(text: widget.name);
    slug = TextEditingController(text: widget.slug);
    quantity = TextEditingController(text: widget.quantity.toString());
    shortDescription = TextEditingController(text: widget.shortDescription);
    description = TextEditingController(text: widget.description);
    regularPrice = TextEditingController(text: widget.regularPrice);
    salePrice = TextEditingController(text: widget.salePrice);
    buyingPrice = TextEditingController(text: widget.buyingPrice);
    sku = TextEditingController(text: widget.sku);
    categoryId = TextEditingController(text: widget.categoryId.toString());
    sizeId = TextEditingController(text: widget.sizeId.toString());

    fetchCategoriesName();
    fetchSizeName();
  }

  Future<void> fetchSizeName() async {
    try {
      final response = await ApiService().getAllSizes();
      if (response.data.data.isNotEmpty) {
        setState(() {
          sizes = response.data.data;
        });
      }
    } catch (error) {
      print('Error fetching sizes Id: $error');
    }
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

  @override
  void dispose() {
    name.dispose();
    slug.dispose();
    shortDescription.dispose();
    quantity.dispose();
    description.dispose();
    regularPrice.dispose();
    salePrice.dispose();
    buyingPrice.dispose();
    sku.dispose();
    categoryId.dispose();
    sizeId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product Screen'),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: textFieldForm(name, 'Name'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: textFieldForm(slug, 'Slug')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: textFieldForm(regularPrice, 'Regular Price'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: textFieldForm(salePrice, 'Sale Price')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: textFieldForm(buyingPrice, 'Buying Price'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: textFieldForm(quantity, 'Quantity')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: textFieldForm(sku, 'SKU')),
                      const SizedBox(width: 10),
                      Expanded(
                        child: textFieldForm(shortDescription, 'Short Desc'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      chooseItemIdForm(
                        DropdownButton(
                          items: categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category.id.toString(),
                              child: Text(category.name.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              categoryId.text = value;
                            });
                          },
                          value: categoryId.text,
                          hint: const Text('Choose One'),
                          underline: const SizedBox(),
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                     SizedBox(width: 10,),
                     chooseItemIdForm(
                       DropdownButton(
                         items: sizes.map((size) {
                           return DropdownMenuItem<String>(
                             value: size.id.toString(),
                             child: Text(size.name.toString()),
                           );
                         }).toList(),
                         onChanged: (value) {
                           setState(() {
                             sizeId.text = value;
                           });
                         },
                         value: sizeId.text,
                         hint: const Text('Choose One'),
                         underline: const SizedBox(),
                         borderRadius: BorderRadius.circular(10),
                         icon: const Icon(Icons.arrow_drop_down),
                         iconSize: 24,
                         isExpanded: true,
                         dropdownColor: Colors.white,
                         style: const TextStyle(
                             color: Colors.black, fontSize: 16),
                       ),
                     )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
