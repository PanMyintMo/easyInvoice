import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../bloc/post/Login&Register/edit_company_profile_cubit.dart';
import '../../common/FormValidator.dart';
import '../../dataRequestModel/Login&Register/EditCompanyProfileRequestModel.dart';

class EditCompanyProfileWidget extends StatefulWidget {
  final String username;
  final String email;
  final String? url;
  final int id;
  final bool isLoading;

  const EditCompanyProfileWidget(
      {super.key,
      required this.isLoading,
      required this.username,
      required this.email,
      this.url,
      required this.id});

  @override
  State<EditCompanyProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditCompanyProfileWidget> {
  var username = TextEditingController();
  var email = TextEditingController();
  late String? newimage;

  File? _image;

  Future<void> _chooseProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        newimage = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    username = TextEditingController(text: widget.username);
    email = TextEditingController(text: widget.email);
    if (widget.url != null && widget.url!.isNotEmpty) {
      newimage = widget.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController mobile = TextEditingController();
    final TextEditingController line1 = TextEditingController();
    final TextEditingController line2 = TextEditingController();
    final TextEditingController city = TextEditingController();
    final TextEditingController country = TextEditingController();
    final TextEditingController zipcode = TextEditingController();
    final TextEditingController company_name = TextEditingController();

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : (widget.url != null && widget.url!.isNotEmpty)
                                    ? Image.network(
                                        widget.url!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.account_circle_rounded,
                                        size: 100,
                                      )),
                      ),
                      Positioned(
                        bottom: -5,
                        right: 0,
                        child: RawMaterialButton(
                          onPressed: _chooseProfilePicture,
                          shape: const CircleBorder(),
                          fillColor: Colors.blueGrey,
                          constraints: const BoxConstraints.tightFor(
                              width: 35, height: 35),
                          child: const Icon(LineAwesomeIcons.camera,
                              color: Colors.black, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              validator: FormValidator.validateName,
                              controller: username,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.pink)),
                                  label: Text("Name"),
                                  prefixIcon: Icon(LineAwesomeIcons.user)),
                            ),
                            const SizedBox(height: 50 - 30),
                            TextFormField(
                              validator: FormValidator.validateEmail,
                              controller: email,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.pink)),
                                  label: Text("Email"),
                                  prefixIcon:
                                      Icon(LineAwesomeIcons.envelope_1)),
                            ),
                            const SizedBox(height: 50 - 30),
                            TextFormField(
                              controller: mobile,
                              validator: (value) => validateFieldlName(value, 'mobile'),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.pink)),
                                  label: Text('Phone'),
                                  prefixIcon: Icon(LineAwesomeIcons.phone)),
                            ),
                            const SizedBox(height: 50 - 30),
                            TextFormField(
                              validator: (value) => validateFieldlName(value,'Line1'),
                              controller: line1,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink)),
                                label: Text('Line1'),
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: line2,
                              validator: (value) => validateFieldlName(value, 'Line 2'),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink)),
                                label: Text('Line2'),
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(height: 50 - 30),
                            TextFormField(
                              controller: city,
                              validator: (value) => validateFieldlName(value, 'City'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink)),
                                label: Text('City'),
                                prefixIcon: Icon(Icons.ac_unit_outlined),
                              ),
                            ),
                            const SizedBox(height: 50 - 30),
                            TextFormField(
                              controller: country,
                              validator: (value) => validateFieldlName(value, 'Country'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink)),
                                label: Text('Country'),
                                prefixIcon: Icon(Icons.fingerprint),
                              ),
                            ),
                            const SizedBox(height: 50 - 30),
                            TextFormField(
                              controller: zipcode,
                              keyboardType: TextInputType.number,
                              validator: (value) => validateFieldlName(value,'ZipCode'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink)),
                                label: Text('Zip Code'),
                                prefixIcon: Icon(Icons.fingerprint),
                              ),
                            ),
                            const SizedBox(height: 50 - 30),
                            TextFormField(
                              controller: company_name,
                              validator: (value) => validateFieldlName(value, 'Company name'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink)),
                                label: Text('Company Name'),
                                prefixIcon: Icon(Icons.fingerprint),
                              ),
                            ),
                            const SizedBox(height: 50 - 30),
                            // -- Form Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    context
                                        .read<EditCompanyProfileCubit>()
                                        .editCompanyProfile(
                                            EditCompanyProfileRequestModel(
                                                mobile: mobile.text,
                                                line1:line1.text,
                                                line2: line2.text,
                                                city: city.text,
                                                country: country.text,
                                                zipcode: zipcode.text,
                                                company_name: company_name.text,
                                                newimage: _image!),
                                            widget.id);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text('Edit Profile',
                                    style: TextStyle(color: Colors.blueGrey)),
                              ),
                            ),
                            const SizedBox(height: 30),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    text: 'Joined',
                                    style: TextStyle(fontSize: 12),
                                    children: [
                                      TextSpan(
                                          text: 'Joined At',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text('Delete'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
