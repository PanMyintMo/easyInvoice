import 'dart:io';
import 'package:easy_invoice/bloc/edit/edit_user_role_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../common/FormValidator.dart';
import '../common/MyCustomClipper.dart';
import '../common/ThemeHelperUserClass.dart';
import '../dataRequestModel/EditUserRoleRequestModel.dart';
import '../module/module.dart';

class EditUserRoleWidget extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String password;
  final String utype;
  final String? newimage;

  const EditUserRoleWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.utype,
    required this.newimage,
  }) : super(key: key);

  @override
  State<EditUserRoleWidget> createState() => _EditUserRoleWidgetState();
}

class _EditUserRoleWidgetState extends State<EditUserRoleWidget> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late String utype;
  late String? newimage;
  final _formKey = GlobalKey<FormState>();
  File? image; // Assuming you have a variable to store the selected image path
  String? selectedUserRole;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
    password = TextEditingController(text: widget.password);
    utype = widget.utype;
    selectedUserRole = widget.utype.isEmpty ? null : widget.utype;
    if (widget.newimage != null && widget.newimage!.isNotEmpty) {
      imageUrl = widget.newimage!;
    } else {
      imageUrl = '';
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _chooseProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        image = file;
        imageUrl = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserRoleCubit(getIt.call()),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    height: 200,
                    color: Colors.redAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Align(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
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
                              right: -20,
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
                          ],
                        ),
                      ],
                    ),
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
                            style: TextStyle(fontSize: 16),
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
                            context.read<EditUserRoleCubit>().editUserRole(
                              EditUserRoleRequestModel(
                                name: name.text,
                                email: email.text,
                                password: password.text,
                                utype: selectedUserRole!,
                                newimage: image != null
                                    ? image!.path
                                    : 'assets/userprofile.png',
                              ),
                              widget.id,
                            );
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
      ),
    );
  }

  Widget getImageWidget() {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      // For Flutter Web and mobile platforms (Android, iOS)
      return image != null
          ? Image(
        image: FileImage(image!),
        fit: BoxFit.cover,
      )
          : imageUrl.isNotEmpty
          ? CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(imageUrl),
      )
          : Icon(
        Icons.person,
        color: Colors.grey.shade300,
        size: 80.0,
      );
    } else {
      // For other platforms (e.g., desktop)
      return image != null
          ? Image.file(
        image!,
        fit: BoxFit.cover,
      ) : imageUrl.isNotEmpty
          ? CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(imageUrl),
      )
          : Icon(
        Icons.person,
        color: Colors.grey.shade300,
        size: 80.0,
      );
    }
  }
}
