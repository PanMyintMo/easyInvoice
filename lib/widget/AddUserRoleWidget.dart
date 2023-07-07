import 'dart:io';

import 'package:easy_invoice/bloc/post/add_user_role_cubit.dart';
import 'package:easy_invoice/common/ThemeHelperUserClass.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../common/FormValidator.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final _formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var utype = TextEditingController();

  File? image; // Assuming you have a variable to store the selected image path
  String? selectedUserRole;

  String? get value => null;

  Future<void> _chooseProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        image = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(
          color: Colors.red, // Set the color of the navigation icon to black
        ),
        title: const Text(
          'Add User Role',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.4,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: getImageWidget(),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF5F6F9),
                        ),
                        child: RawMaterialButton(
                          onPressed: _chooseProfilePicture,
                          elevation: 4.0,
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
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 20,right: 30),
                          child: Icon(Icons.accessibility),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black12, width: 2),
                          borderRadius: BorderRadius.circular(50), // Rounded corners
                        ),
                      ),
                      dropdownColor: Colors.grey,
                      value: selectedUserRole,
                      onChanged: (String? newValue) {
                        selectedUserRole = newValue;
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
                      items: const [
                        "User",
                        "Admin (Disabled)",
                        "Warehouse",
                        'Shopkeeper',
                        "Delivery"
                      ].map<DropdownMenuItem<String>>((String value) {
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
                            } else {
                              context.read<AddUserRoleCubit>().addUser(
                                    UserRequestModel(
                                      name: name.text,
                                      email: email.text,
                                      password: password.text,
                                      utpye: selectedUserRole!,
                                      newimage: image != null
                                          ? image!.path
                                          : 'assets/userprofile.png',
                                    ),
                                  );
                              //  print('User role: $selectedUserRole');
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Add User Role',
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
      ),
    );
  }

  Widget getImageWidget() {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      // For Flutter Web and mobile platforms (Android, iOS)
      return image != null
          ? ClipOval(
              child: Image(
                image: FileImage(image!),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            )
          : Icon(
              Icons.person,
              color: Colors.grey.shade300,
              size: 80.0,
            );
    } else {
      // For other platforms (e.g., desktop)
      return image != null
          ? ClipOval(
              child: Image.file(
                image!,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            )
          : Icon(
              Icons.person,
              color: Colors.grey.shade300,
              size: 80.0,
            );
    }
  }
}
