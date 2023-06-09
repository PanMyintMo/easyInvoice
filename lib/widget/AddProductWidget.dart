import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_invoice/bloc/post/add_product_cubit.dart';
import 'package:easy_invoice/common/ToastMessage.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/dataRequestModel/AddProductRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../common/CustomShapeForProduct.dart';
import '../common/ThemeHelperUserClass.dart';
import '../data/responsemodel/GetAllCategoryDetail.dart';
import '../data/responsemodel/GetAllSizeResponse.dart';
import '../module/module.dart';

class AddProductWidget extends StatefulWidget {
  final bool isLoading; // Add the isLoading property
  final String message;

  const AddProductWidget(
      {Key? key, required this.isLoading, required this.message})
      : super(key: key);

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  var name = TextEditingController();
  var slug = TextEditingController();
  var regular_price = TextEditingController();
  var sale_price = TextEditingController();
  var buying_price = TextEditingController();
  var SKU = TextEditingController();
  var quantity = TextEditingController();
  var short_description = TextEditingController();
  var description = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  List<CategoryItem> cateIdList = [];
  String? categoryId; // Declare categoryId as nullable


  List<SizeItems> sizeIdList = [];
  String? sizeId;

  @override
  void initState() {
    super.initState();
    fetchCategoriesName();
    fetchSizeName();

    name.addListener(() {
      _updateSlugField();
    });
  }

  Future<void> fetchSizeName() async {
    try {
      final response = await ApiService().getAllSizes();
      if (response.data.data.isNotEmpty) {
        setState(() {
          sizeIdList = response.data.data;
          sizeId = sizeIdList[0].id.toString();
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
          cateIdList = response.data.data;
          categoryId =
              cateIdList[0].id.toString(); // Set a default value if available
        });
      }
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
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 120,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.redAccent,
              child: const Center(
                child: Text(
                  "Add Product Screen",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView(
                children: [
            Container(
            padding: const EdgeInsets.fromLTRB(27, 25, 20, 40),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                        items: categoryId != null ? cateIdList.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: Text(category.name.toString()),
                          );
                        }).toList() : [],
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
                    chooseItemIdForm(
                      DropdownButton(
                        items: sizeId != null ? sizeIdList.map((size) {
                          return DropdownMenuItem<String>(
                            value: size.id.toString(),
                            child: Text(size.name.toString()),
                          );
                        }).toList() : [],
                        value: sizeId,
                        onChanged: (newValue) {
                          setState(() {
                            sizeId = newValue;
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
                const SizedBox(
                height: 10,
                ),
                Row(
                children: [
                  buildProductContainerForm(
                    'Product Name', TextInputType.name, name,
                    validateProductField) ,
                    const SizedBox(
                      width: 10,
                    ),
                    buildProductContainerForm(
                        'Slug', TextInputType.name, slug,
                      validateProductField
                    ),
                    ],
                  ),
                ],
                ),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildProductContainerText("Regular Price"),
                  buildProductContainerForm('Regular Price',
                      TextInputType.number, regular_price, validateProductField),
                ],
            ),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildProductContainerText("Sale Price"),
                  buildProductContainerForm(
                      'Sale Price', TextInputType.number, sale_price,
                      validateProductField),
                ],
            ),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildProductContainerText("Buying Price"),
                  buildProductContainerForm('Buying Price',
                      TextInputType.number, buying_price, validateProductField),
                ],
            ),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildProductContainerText("SKU"),
                  buildProductContainerForm(
                      'SKU', TextInputType.text, SKU, validateProductField),
                ],
            ),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildProductContainerText("Quantity"),
                  buildProductContainerForm(
                      'Quantity', TextInputType.number, quantity,
                      validateProductField),
                ],
            ),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildProductContainerText("Short description"),
                  buildProductContainerForm('Short description',
                      TextInputType.text, short_description, validateProductField),
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
                    controller: description,
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
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                      buildProductContainerText("Upload Image"),
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
                    if (_formKey.currentState!.validate())
                      _submitForm();
                  },
                  child: const Text('Submit'))
          ],
        ),
              ),
      ),
    ),
    ],
    ),
    if (widget.isLoading)
    Container(
    color: Colors.black.withOpacity(0.5),
    child: const Center(
    child: CircularProgressIndicator(),
    ),
    ),
    ],
    )
    ,
    )
    ,
    );
  }

  void _submitForm() async {
    final addProductCubit = context.read<AddProductCubit>();

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
          newimage: '',
          category_id: categoryId ?? '',
          size_id: sizeId ?? ''));

      // Show success toast
      showToastMessage('Product successfully added.');
    } catch (e) {
      //show error toast
      showToastMessage('Fail add product $e!');
    }
  }

  String? validateProductField(String? value) {
    if (value!.isEmpty) {
      return 'Please fill this field!';
    }
    return null;
  }

  void _updateSlugField() {
    final productName = name.text;
    final slugName = productName.toLowerCase().replaceAll(' ', '_');

    setState(() {
      slug.text = slugName;
    });
  }

}

