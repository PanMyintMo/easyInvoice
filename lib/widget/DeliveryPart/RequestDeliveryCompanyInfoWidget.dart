import 'package:dotted_border/dotted_border.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import 'package:easy_invoice/screen/DeliveryPart/AddDeliveryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../bloc/post/DeliveryPart/add_delivery_cubit.dart';
import '../../common/DynamicImageWidget.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';


class RequestDeliveryCompanyWidget extends StatefulWidget {
  final bool isLoading;

  const RequestDeliveryCompanyWidget({super.key, required this.isLoading});

  @override
  State<RequestDeliveryCompanyWidget> createState() => _RequestDeliveryCompanyWidgetState();
}

class _RequestDeliveryCompanyWidgetState extends State<RequestDeliveryCompanyWidget> {
  File? image;
  final name = TextEditingController();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddDeliveryScreen(),
                              ),
                            );
                          },
                          child: const Text(
                              "Add Delivery Info"
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: buildProductContainerText("Delivery Name"),
                      ),
                      Container(
                        padding : const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: buildProductContainerForm(
                          'Name',
                          TextInputType.name,
                          name,
                          validateField,
                        ),
                      ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: buildProductContainerText("Upload Image"),
                        ),
                        const SizedBox(height : 16),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                                  child: DynamicImageWidget(image: image,
                                    onTap: () {
                                      pickImage();
                                    },

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height : 16),

                        Center(
                          child: ElevatedButton(
                            style: ThemeHelperUserRole().buttonStyle(),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AddDeliveryCubit>().addDelivery(
                                  AddDeliveryRequestModel(
                                    name: name.text.toString(),
                                    image: image!,
                                  ),
                                );
                              }
                            },
                            child: const Text('Add Delivery Info'),
                          ),
                        ),

                    ],
                    )
                ),
              )
            ],
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
    );
  }
}




