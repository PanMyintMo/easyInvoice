import 'dart:io';
import 'package:easy_invoice/bloc/edit/edit_user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../common/FormValidator.dart';
import '../common/HeaderWidget.dart';
import '../common/ThemeHelperUserClass.dart';
import '../dataRequestModel/EditUserRoleRequestModel.dart';


class EditUserRoleWidget extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String password;
  final String utype;
  final File? newimage;
  final Function()? onSave;

  const EditUserRoleWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.utype,
    required this.newimage,
    this.onSave,
  }) : super(key: key);

  @override
  State<EditUserRoleWidget> createState() => _EditUserRoleWidgetState();
}

class _EditUserRoleWidgetState extends State<EditUserRoleWidget> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late String utype;

  final _formKey = GlobalKey<FormState>();
  File? image; // Variable to store the selected image
  String? selectedUserRole;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
    password = TextEditingController(text: widget.password);
    utype = widget.utype;
    selectedUserRole = utype.isNotEmpty ? getDropdownValueFromUtype(utype) : null;
    image = widget.newimage; // Initialize the image variable
  }

  Future<void> _chooseProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        image = file; // Update the image variable
      });
    }
  }

  String? getUtypeFromDropdownValue(String value) {
    if (value == "User") {
      return "USR";
    } else if (value == "Admin") {
      return "ADM";
    } else if (value == "Warehouse") {
      return "WH";
    } else if (value == "Delivery") {
      return "DELI";
    } else if (value == "ShopKeeper") {
      return "SK";
    }
    return null;
  }

  String? getDropdownValueFromUtype(String utype) {
    if (utype == "USR") {
      return "User";
    } else if (utype == "ADM") {
      return "Admin";
    } else if (utype == "WH") {
      return "Warehouse";
    } else if (utype == "DELI") {
      return "Delivery";
    } else if (utype == "SK") {
      return "ShopKeeper";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> userTypes = [
      "User",
      "Admin",
      "Warehouse",
      "Delivery",
      "ShopKeeper",
    ];

    return Stack(
      children: [
        ListView(
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 150,
                  child: HeaderWidget(
                    150,
                    false,
                    Icons.person_add_alt_1_rounded,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white24),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Stack(
                            children: [
                              if (image != null)
                                Image.file(
                                  image!, // Display image from local file path
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      color: Colors.grey.shade300,
                                      size: 130.0,
                                    );
                                  },
                                )
                              else
                                Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 130.0,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF5F6F9),
                          ),
                          child: RawMaterialButton(
                            onPressed: _chooseProfilePicture,
                            elevation: 3.0,
                            fillColor: const Color(0xFFF5F6F9),
                            padding: const EdgeInsets.all(10.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildInputContainer(
                      'Name',
                      'Enter your name',
                      Icons.account_circle_rounded,
                      name,
                      FormValidator.validateName,
                      TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    buildInputContainer(
                      'Email',
                      'Enter your email',
                      Icons.email,
                      email,
                      FormValidator.validateEmail,
                      TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    buildInputContainer(
                      'Password',
                      'Enter your password',
                      Icons.remove_red_eye_outlined,
                      password,
                      FormValidator.validatePassword,
                      TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 20, right: 30),
                          child: Icon(Icons.accessibility),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black12, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      dropdownColor: Colors.grey,
                      value: selectedUserRole,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUserRole = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a user role'; // Validation error message
                        }
                        return null; // Validation passed
                      },
                      hint: const Text(
                        'Select a user role',
                        style: TextStyle(fontSize: 16),
                      ),
                      items: userTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ThemeHelperUserRole().buttonStyle(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            if (selectedUserRole == null ||
                                selectedUserRole!.isEmpty) {
                              return;
                            }
                            final String? utype =
                            getUtypeFromDropdownValue(selectedUserRole!);
                            if (utype != null) {
                              setState(() {
                                isSaving = true;
                              });
                              context
                                  .read<EditUserRoleCubit>()
                                  .editUserRole(
                                EditUserRoleRequestModel(
                                  name: name.text,
                                  email: email.text,
                                  password: password.text,
                                  utype: utype,
                                  newimage: image, // You might need to handle this
                                ),
                                widget.id,
                              )
                                  .then((_) {
                                setState(() {
                                  isSaving = false;
                                });
                              });
                              widget.onSave?.call();
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Edit User Role',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        if (isSaving)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
