import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../common/ThemeHelperUserClass.dart';

class AddDeliveryWidget extends StatefulWidget {
  const AddDeliveryWidget({super.key});

  @override
  State<AddDeliveryWidget> createState() => _AddDeliveryWidgetState();
}

class _AddDeliveryWidgetState extends State<AddDeliveryWidget> {
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('All Deliveries')),
              ),
              const SizedBox(
                height: 10,
              ),
             // const Text('Delivery Name'),
             /* const SizedBox(
                height: 10,
              ),*/
              Container(
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Delivery Name',
                      hintText: 'Delivery Name'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Add Delivery')),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(child: Text('Choose Delivery')),
                  Expanded(
                      child: chooseItemIdForm(DropdownButton(
                    items: [],
                    onChanged: (value) {
                      setState(() {
                        // size_id.text = value;
                      });
                    },
                    //  value: size_id.text,
                    hint: const Text('Select Company Name'),
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
                  )))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(child: Text('Choose City')),
                  Expanded(
                      child: chooseItemIdForm(DropdownButton(
                    items: [],
                    onChanged: (value) {
                      setState(() {
                        // size_id.text = value;
                      });
                    },
                    //  value: size_id.text,
                    hint: const Text('Select City'),
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
                  )))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(child: Text('Choose Township')),
                  Expanded(
                      child: chooseItemIdForm(DropdownButton(
                    items: [],
                    onChanged: (value) {
                      setState(() {
                        // size_id.text = value;
                      });
                    },
                    //  value: size_id.text,
                    hint: const Text('Select  Township'),
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
                  )))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(child: Text('Basic Cost')),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            labelText: 'Basic Cost',
                            hintText: 'Basic Cost'),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(child: Text('Waiting Time')),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            labelText: 'Waiting Time',
                            hintText: 'Waiting Time'),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              const Text('Upload Image'),
              const SizedBox(
                height: 10,
              ),
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
                      child: buildImageWidget(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: validateAndSubmit, child: const Text('Add New')),
              ),
            ],
          ),
        ),

      ],
    );
  }

  void validateAndSubmit() async {}
}
