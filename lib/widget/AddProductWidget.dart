import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_invoice/bloc/post/add_product_cubit.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/dataRequestModel/AddProductRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../common/ThemeHelperUserClass.dart';
import '../data/responsemodel/GetAllCategoryDetail.dart';
import '../module/module.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget(
      {Key? key, required bool isLoading, required String message})
      : super(key: key);

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {

  var productNameController = TextEditingController();
  var slugNameController = TextEditingController();
  var regularPriceController = TextEditingController();
  var salePriceController = TextEditingController();
  var buyingPriceController = TextEditingController();
  var skuController = TextEditingController();
  var qualityController = TextEditingController();
  var shortDescController = TextEditingController();
  var longDescriptionController = TextEditingController();


  List<CategoryItem> cateIdList = [];
  String? categoryId; // Declare categoryId as nullable

  @override
  void initState() {
    super.initState();
    fetchCategoriesName();

    productNameController.addListener(() {
      _updateSlugField();
    });
  }

  Future<void> fetchCategoriesName() async {
    try {
      final response = await ApiService().getAllCategories();
      setState(() {
        cateIdList = response.data.data;
        categoryId =
        (cateIdList.isNotEmpty ? cateIdList[0].name : null);
      });
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget buildImageWidget() {
    if (image != null) {
      return Image.file(
        image!,
        fit: BoxFit.cover,
      );
    } else {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload,
            size: 40,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'Upload Image',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(getIt.call()),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(27, 25, 20, 40),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProductContainerText("Category Id"),
                      buildProductContainerText("Size Id"),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      chooseItemIdForm(
                        DropdownButton(
                          items: cateIdList.map((category) {
                            return DropdownMenuItem(
                              value: category.name,
                              child: Text(category.name.toString()),
                            );
                          }).toList(),
                          value: categoryId,
                          // the selected value,
                          onChanged: (newValue) {
                            setState(() {
                              categoryId = newValue;
                            });
                          },
                          hint: const Text('Choose One'),
                          underline: SizedBox(),
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // chooseItemIdForm(
                      //   DropdownButton(
                      //     items: cateIdList.map((category) {
                      //       return DropdownMenuItem(
                      //         value: category.id,
                      //         child: Text(category.id.toString()),
                      //       );
                      //     }).toList(),
                      //     value: categoryId,
                      //     onChanged: (newValue) {
                      //       setState(() {
                      //         categoryId = newValue;
                      //       });
                      //     },
                      //     hint: const Text('Choose One'),
                      //     underline: SizedBox(),
                      //     borderRadius: BorderRadius.circular(10),
                      //     icon: const Icon(Icons.arrow_drop_down),
                      //     iconSize: 24,
                      //     isExpanded: true,
                      //     dropdownColor: Colors.white,
                      //     style: const TextStyle(
                      //         color: Colors.black, fontSize: 16),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          buildProductContainerText("Product"),
                          buildProductContainerText("Slug Name"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          buildProductContainerForm(
                              'Product Name',
                              TextInputType.name,
                              productNameController, (value) {
                            if (value.isEmpty) {
                              return 'Plese add product name!';
                            }
                          }),
                          const SizedBox(
                            width: 10,
                          ),
                          buildProductContainerForm(
                              'Slug', TextInputType.name, slugNameController,
                                  (value) {
                                if (value.isEmpty) {
                                  return 'Plese add slug name!';
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProductContainerText("Regular Price"),
                      buildProductContainerForm(
                          "Regular Price",
                          TextInputType.number,
                          regularPriceController, (value) {
                        if (value.isEmpty) {
                          return 'Plese add Regular Price!';
                        }
                      }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProductContainerText("Sale Price"),
                      buildProductContainerForm("Sale Price",
                          TextInputType.number, salePriceController, (value) {
                            if (value.isEmpty) {
                              return 'Plese add sale price!';
                            }
                          }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProductContainerText("Buying Price"),
                      buildProductContainerForm("Buying Price",
                          TextInputType.number, buyingPriceController, (value) {
                            if (value.isEmpty) {
                              return 'Plese add buying name!';
                            }
                          }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProductContainerText("SKU"),
                      buildProductContainerForm(
                          "SKU", TextInputType.text, skuController, (value) {
                        if (value.isEmpty) {
                          return 'Plese add sku!';
                        }
                      }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProductContainerText("Quantity"),
                      buildProductContainerForm(
                          "Quantity", TextInputType.number, qualityController,
                              (value) {
                            if (value.isEmpty) {
                              return 'Plese add quantity!';
                            }
                          }),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProductContainerText("Short description"),
                      buildProductContainerForm("Short description",
                          TextInputType.text, shortDescController, (value) {
                            if (value.isEmpty) {
                              return 'Plese add short description!';
                            }
                          }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: buildProductContainerText("Description"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        maxLines: 4,
                        controller: longDescriptionController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: // Existing code...

                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildProductContainerText("Upload Image"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: DottedBorder(
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
                                      child: buildImageWidget(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final addProductCubit = context.read<AddProductCubit>();

                        addProductCubit.addProduct(AddProductRequestModel(
                            name: productNameController.text,
                            slug: slugNameController.text,
                            short_description: shortDescController.text,
                            description: longDescriptionController.text,
                            regular_price: regularPriceController.text,
                            sale_price: salePriceController.text,
                            buying_price: buyingPriceController.text,
                            SKU: skuController.text,
                            quantity: qualityController.text,
                            newimage: '',
                            category_id: '64',
                            size_id: '4'));
                      },
                      child: const Text('Submit'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateSlugField() {
    final productName = productNameController.text;
    final slugName = productName.toLowerCase().replaceAll(' ', '_');

    setState(() {
      slugNameController.text = slugName;
    });
  }
}


