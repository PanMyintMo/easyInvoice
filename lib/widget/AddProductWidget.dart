import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_invoice/bloc/post/ProductPart/add_product_cubit.dart';
import 'package:easy_invoice/dataRequestModel/AddProductRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../common/ApiHelper.dart';
import '../common/DynamicImageWidget.dart';
import '../common/FormValidator.dart';
import '../common/ThemeHelperUserClass.dart';
import '../data/responseModel/GetAllPaganizationDataResponse.dart';

class AddProductWidget extends StatefulWidget {
  final bool isLoading; // Add the isLoading property

  const AddProductWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final TextEditingController name = TextEditingController();
  var slug = TextEditingController();
  var regular_price = TextEditingController();
  var sale_price = TextEditingController();
  var buying_price = TextEditingController();
  var SKU = TextEditingController();
  var quantity = TextEditingController();
  var short_description = TextEditingController();
  var description = TextEditingController();

  String? category_id;
  String? sizeId;
  List<PaganizationItem> categories = [];
  List<PaganizationItem> sizeIdList = [];

  @override
  void initState() {
    super.initState();

    fetchCategoriesName();
    fetchSizeName();
  }

  @override
  void dispose() {
    name.dispose();
    slug.dispose();
    regular_price.dispose();
    sale_price.dispose();
    buying_price.dispose();
    SKU.dispose();
    quantity.dispose();
    short_description.dispose();
    description.dispose();
    super.dispose();
  }


  Future<void> fetchSizeName() async {
    final sizeIdList = await ApiHelper.fetchSizeName();
    setState(() {
      this.sizeIdList = sizeIdList!;
    });
  }

  void fetchCategoriesName() async {
    final categories = await ApiHelper.fetchCategoriesName();
    setState(() {
      this.categories = categories!;
    });
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } catch (e) {
      //print('Failed to pick image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProductContainerText("Category Id",context),
                  const SizedBox(height: 5),
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
                          category_id = value!;
                        });
                      },
                      hint: "Select Category",context: context
                    ),
                  ),
                  const SizedBox(height: 5),
                  buildProductContainerText("Size Id",context),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: sizeId,
                      items: sizeIdList.map((size) {
                        return DropdownMenuItem(
                          value: size.id.toString(),
                          child: Text(size.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          sizeId = value!;
                        });
                      },
                      hint: "Select Size", context: context,
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildProductContainerText("Product Name",context),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Name',
                      ),
                      onChanged: (value) {
                        _updateSlugField(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: buildProductContainerText("Slug Name",context)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: slug,
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Slug Name',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerText("Regular Price",context),
                      ),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          'Regular Price',
                          TextInputType.number,
                          regular_price,
                          validateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerText("Sale Price",context),
                      ),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          'Sale Price',
                          TextInputType.number,
                          sale_price,
                          validateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerText("Buying Price",context),
                      ),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          'Buying Price',
                          TextInputType.number,
                          buying_price,
                          validateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerText("SKU",context),
                      ),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          'SKU',
                          TextInputType.text,
                          SKU,
                          validateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerText("Quantity",context),
                      ),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          'Quantity',
                          TextInputType.number,
                          quantity,
                          validateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerText("Short description",context),
                      ),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          'Short description',
                          TextInputType.text,
                          short_description,
                          validateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildProductContainerText("Description",context),
                  ),
                  const SizedBox(height: 16),
                  buildProductContainerForm('Description', TextInputType.text,
                      description, validateField),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildProductContainerText("Upload Image",context),
                  ),
                  const SizedBox(height: 16),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    color: Colors.grey,
                    strokeWidth: 1,
                    radius: const Radius.circular(10),
                    dashPattern: const [4, 4],
                    child: InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Center(
                          child: DynamicImageWidget(image: image,
                            onTap: () {
                              pickImage();
                            },

                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) _submitForm();
                      },
                      child:  Text('Submit',style: TextStyle(color: AdaptiveTheme.of(context).theme.iconTheme.color),),
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
            ),
          ),
        )
      ],
    );
  }

  void _submitForm() async {
    final addProductCubit = context.read<AddProductCubit>();

    // Validate if category and size are selected
    if (category_id == 'Select Category' || sizeId == 'Select Size') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please choose a category and size.'),
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
      return;
    }

    try {
      await addProductCubit.addProduct(AddProductRequestModel(
          name: name.text,
          slug: slug.text,
          short_description: short_description.text,
          description: description.text,
          regular_price: regular_price.text,
          sale_price: sale_price.text,
          buying_price: buying_price.text,
          SKU: SKU.text,
          quantity: quantity.text,
          newimage: image,
          category_id: category_id!,
          size_id: sizeId!));
    } catch (e) {}
  }

  void _updateSlugField(String productName) {
    final slugName = productName.toLowerCase().replaceAll(' ', '-');
    slug.text = slugName;
  }
}