import 'package:easy_invoice/dataRequestModel/EditProductRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/edit/edit_product_item_cubit.dart';
import '../common/ThemeHelperUserClass.dart';
import '../common/ToastMessage.dart';
import '../data/api/ConnectivityService.dart';
import '../data/api/apiService.dart';
import '../data/responseModel/GetAllPaganizationDataResponse.dart';

class EditProductItemScreen extends StatefulWidget {
  final int id;
  final String name;
  final String slug;
  final String short_description;
  final String description;
  final String regular_price;
  final String sale_price;
  final String buying_price;
  final String SKU;
  final int quantity;
  final int category_id;
  final int size_id;
  final String newimage;


  const EditProductItemScreen({
    Key? key,
    required this.name,
    required this.slug,
    required this.short_description,
    required this.description,
    required this.regular_price,
    required this.sale_price,
    required this.buying_price,
    required this.SKU,
    required this.quantity,
    required this.category_id,
    required this.size_id,
    required this.id,
    required this.newimage,
  }) : super(key: key);

  @override
  State<EditProductItemScreen> createState() => _EditProductItemScreenState();
}

class _EditProductItemScreenState extends State<EditProductItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController slug;
  late TextEditingController short_description;
  late TextEditingController quantity;
  late TextEditingController description;
  late TextEditingController regular_price;
  late TextEditingController sale_price;
  late TextEditingController buying_price;
  late TextEditingController sku;
  late TextEditingController category_id;
  late TextEditingController size_id;

  List<PaganizationItem> categories = [];
  List<PaganizationItem> sizes = [];
  bool isLoading = false;
   late Widget networkImage;

  @override
  void initState() {
    super.initState();

    name = TextEditingController(text: widget.name);
    slug = TextEditingController(text: widget.slug);
    quantity = TextEditingController(text: widget.quantity.toString());
    short_description = TextEditingController(text: widget.short_description);
    description = TextEditingController(text: widget.description);
    regular_price = TextEditingController(text: widget.regular_price);
    sale_price = TextEditingController(text: widget.sale_price);
    buying_price = TextEditingController(text: widget.buying_price);
    sku = TextEditingController(text: widget.SKU);
    category_id = TextEditingController(text: widget.category_id.toString());
    size_id = TextEditingController(text: widget.size_id.toString());

    name.addListener(_updateSlugField);
    fetchCategoriesName();
    fetchSizeName();

    if (widget.newimage.isNotEmpty) {
      networkImage = Image.network(
        widget.newimage,
        width: 200,
        height: 200,
        fit: BoxFit.scaleDown,
      );
    }
    else{
      networkImage = Image.asset(
        'assets/profits.png', // Replace with the path to your default image
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    }
  }

  Future<void> fetchSizeName() async {
    try {
      final response = await ApiService(ConnectivityService()).getAllSizes();
      if (response.data.isNotEmpty) {
        setState(() {
          sizes = response.data;
        });
      }
    } catch (error) {
      print('Error fetching sizes Id: $error');
    }
  }

  Future<void> fetchCategoriesName() async {
    try {
      final response = await ApiService(ConnectivityService()).getAllCategories();
      if (response.data.isNotEmpty) {
        setState(() {
          categories = response.data;
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
    short_description.dispose();
    quantity.dispose();
    description.dispose();
    regular_price.dispose();
    sale_price.dispose();
    buying_price.dispose();
    sku.dispose();
    category_id.dispose();
    size_id.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProductItemCubit, EditProductItemState>(
      listener: (context, state) {
        if (state is EditProductItemLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is EditProductItemFail) {
          setState(() {
            isLoading = false;
          });
          showToastMessage("Failed to update product item: ${state.error}");
        } else if (state is EditProductItemSuccess) {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context, true); // Navigate back with success result
          showToastMessage("Product Item has been updated successfully.");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white24,
            iconTheme: const IconThemeData(
              color: Colors.red, // Set the color of the navigation icon to black
            ),
            title: const Text('Edit Product Screen',style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
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
                            child:
                                textFieldForm(regular_price, 'Regular Price'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: textFieldForm(sale_price, 'Sale Price'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: textFieldForm(buying_price, 'Buying Price'),
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
                            child:
                                textFieldForm(short_description, 'Short Desc'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          // chooseItemIdForm(
                          //
                          //   DropdownButton(
                          //     items: categories.map((category) {
                          //       return DropdownMenuItem<String>(
                          //         value: category.id.toString(),
                          //         child: Text(category.name.toString()),
                          //       );
                          //     }).toList(),
                          //     onChanged: (value) {
                          //       setState(() {
                          //         category_id.text = value;
                          //       });
                          //     },
                          //     value: category_id.text,
                          //     hint: const Text('Choose One'),
                          //     underline: const SizedBox(),
                          //     borderRadius: BorderRadius.circular(10),
                          //     icon: const Icon(Icons.arrow_drop_down),
                          //     iconSize: 24,
                          //     isExpanded: true,
                          //     dropdownColor: Colors.white,
                          //     style: const TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 16,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          // chooseItemIdForm(
                          //   DropdownButton(
                          //     items: sizes.map((size) {
                          //       return DropdownMenuItem<String>(
                          //         value: size.id.toString(),
                          //         child: Text(size.name.toString()),
                          //       );
                          //     }).toList(),
                          //     onChanged: (value) {
                          //       setState(() {
                          //         size_id.text = value;
                          //       });
                          //     },
                          //     value: size_id.text,
                          //     hint: const Text('Choose One'),
                          //     underline: const SizedBox(),
                          //     borderRadius: BorderRadius.circular(10),
                          //     icon: const Icon(Icons.arrow_drop_down),
                          //     iconSize: 24,
                          //     isExpanded: true,
                          //     dropdownColor: Colors.white,
                          //     style: const TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 16,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    SizedBox(
                        height: 250,
                        width: 200,
                        child: networkImage
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<EditProductItemCubit>().editProductItem(
                                EditProductRequestModel(
                                  name: name.text,
                                  slug: slug.text,
                                  short_description: short_description.text,
                                  description: description.text,
                                  regular_price: regular_price.text,
                                  sale_price: sale_price.text,
                                  buying_price: buying_price.text,
                                  SKU: sku.text,
                                  quantity: quantity.text,
                                  category_id: category_id.text,
                                  size_id: size_id.text,
                                  newimage: '',
                                ),
                                widget.id,
                              );
                        },
                        child: Text(state is EditProductItemLoading
                            ? 'Submitting...'
                            : 'Submit'),
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _updateSlugField() {
    final updateCateName = name.text;
    final updateSlugName = updateCateName.toLowerCase().replaceAll(' ', '-');

    setState(() {
      slug.text = updateSlugName;
    });
  }
}
