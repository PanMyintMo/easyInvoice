import 'dart:io';
import 'package:easy_invoice/bloc/post/add_user_role_cubit.dart';
import 'package:easy_invoice/common/ThemeHelperUserClass.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../common/FormValidator.dart';

class UserWidget extends StatefulWidget {
  final bool isLoading; // Add the isLoading property

  const UserWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final _formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var utype = TextEditingController();

  List<String> userItems = [
    "User",
    "Admin (Disabled)",
    "Warehouse",
    'Shopkeeper',
    "Delivery"
  ];

  File? image; // Assuming you have a variable to store the selected image path
  String? selectedUserRole;

  @override
  Widget build(BuildContext context) {
    bool _isAddingUser = false;

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

    return Stack(
      children: [
        SingleChildScrollView(
            child: Column(children: [
          Center(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
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
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
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
                      TextInputType.name),
                  const SizedBox(height: 16),
                  buildInputContainer(
                    'Email',
                    'Enter your email',
                    Icons.email,
                    email,
                    FormValidator.validateEmail,
                    TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  buildInputContainer(
                    'Password',
                    'Enter your password',
                    Icons.remove_red_eye_outlined,
                    password,
                    FormValidator.validatePassword,
                    TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: selectedUserRole,
                      items: userItems.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedUserRole = value;
                        });
                      },
                      hint: "Select a user role",
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ThemeHelperUserRole().buttonStyle(),
                      onPressed: () {
                        if (!_isAddingUser && _formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          if (selectedUserRole == null ||
                              selectedUserRole!.isEmpty) {
                            return;
                          } else {
                            // Disable the button to prevent multiple submissions
                            setState(() {
                              _isAddingUser = true;
                            });

                            context
                                .read<AddUserRoleCubit>()
                                .addUser(
                                  UserRequestModel(
                                      name: name.text,
                                      email: email.text,
                                      password: password.text,
                                      utpye: selectedUserRole!,
                                      newimage: image),
                                )
                                .then((result) {
                              // Enable the button after the user request is completed (success or fail)
                              setState(() {
                                _isAddingUser = false;
                              });
                            });
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

        ])),
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
