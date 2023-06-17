import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_invoice/common/ThemeHelperUserClass.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/post/user_cubit.dart';
import '../common/FormValidator.dart';
import '../common/MyCustomClipper.dart';

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
  String imageUrl='https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'; //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials

  File? image; // Assuming you have a variable to store the selected image path
  String? selectedUserRole;

  Future<void> _chooseProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        image = file;
        imageUrl = file.path; // Update the imageUrl with the selected image file path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'User Role',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: SingleChildScrollView(
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
                  padding: const EdgeInsets.only(top: 80),
                  child: Align(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                    CircularProfileAvatar(
                      imageUrl,
                      radius: 70,
                      backgroundColor: Colors.transparent, // sets background color, default Colors.white
                      borderColor: Colors.white, // sets border color, default Colors.white
                      elevation: 6.0, // sets elevation (shadow of the profile picture), default value is 0.0
                      foregroundColor: Colors.brown.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                      cacheImage: true, // allow widget to cache image against provided url
                      onTap: () {}, // sets on tap
                      showInitialTextAbovePicture: true,
                      child:  getImageWidget()
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
                        FormValidator.validateName,TextInputType.name),
                    const SizedBox(height: 10),
                    buildInputContainer('Email', 'Enter your email', Icons.email,
                        email, FormValidator.validateEmail,TextInputType.emailAddress,),
                    const SizedBox(height: 10),
                    buildInputContainer(
                        'Password',
                        'Enter your password',
                        Icons.remove_red_eye_outlined,
                        password,
                        FormValidator.validatePassword,TextInputType.visiblePassword,),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Set the desired border color
                          width: 1.0, // Set the desired border width
                        ),
                        borderRadius: BorderRadius.circular(
                            40.0), // Set the desired border radius
                      ),
                      child: DropdownSearch<String>(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a user role!';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                        //  print(value);
                          selectedUserRole = value;
                        },
                        popupProps: PopupProps.menu(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: const [
                          "User",
                          "Admin (Disabled)",
                          "Warehouse",
                          'Shopkeeper',
                          "Delivery"
                        ],
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Select User Role",
                            border: OutlineInputBorder(
                              // Set the outline border
                              borderSide: BorderSide
                                  .none,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 30),
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
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
                            else{
                              context.read<UserCubit>().addUser(
                                UserRequestModel(
                                name: name.text,email: email.text,password: password.text,utpye: selectedUserRole!, newimage: image != null ? image!.path : 'assets/userprofile.png'),
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
          ? Image.network(
        imageUrl,
        fit: BoxFit.cover,
      )
          : Image.asset('assets/userprofile.png');
    } else {
      // For other platforms (e.g., desktop)
      return image != null
          ? Image.file(
        image!,
        fit: BoxFit.cover,
      )
          : Image.asset('assets/userprofile.png');
    }
  }
}
