import 'package:easy_invoice/bloc/delete/delete_user_role_cubit.dart';
import 'package:easy_invoice/common/ThemeHelperUserClass.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/screen/UpdateUserRoleScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../common/HeaderWidget.dart';
import '../common/theme_helper.dart';

class UserDetailProfileScreen extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final DateTime created_at;
  final DateTime updated_at;
  final String utype;
  final String profileImageUrl;

  const UserDetailProfileScreen(
      {Key? key,
      required this.id,
      required this.name,
      required this.email,
      required this.created_at,
      required this.updated_at,
      required this.utype,
      required this.profileImageUrl})
      : super(key: key);

  @override
  State<UserDetailProfileScreen> createState() =>
      _UserDetailProfileScreenState();
}

class _UserDetailProfileScreenState extends State<UserDetailProfileScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteUserRoleCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
           flexibleSpace: Container(
           decoration: BoxDecoration(
              gradient: LinearGradient(
                   colors: [Colors.redAccent.withOpacity(0.3),Colors.pink.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                 end: Alignment.topCenter
             ),
           ),
         ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          title: Center(
            child: Text(
              'User Role Detail Profile',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserRoleScreen(
                              id: widget.id,
                              name: widget.name,
                              password: '',
                              utype: widget.utype,
                              email: widget.email,
                              newimage: widget.profileImageUrl)));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ))
          ],
        ),
        body: BlocBuilder<DeleteUserRoleCubit, DeleteUserRoleState>(
          builder: (context, state) {
            if (state is DeleteUserRoleLoading) {
              isLoading = true;
            }
            return Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                            height: 150,
                            child: HeaderWidget(
                                150, false, Icons.person_add_alt_1_rounded)),
                        Container(
                          margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 5, color: Colors.white),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: widget.profileImageUrl.isNotEmpty
                                ? Image.network(
                                    widget.profileImageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Display a fallback icon if the image fails to load
                                      return Icon(
                                        Icons.person,
                                        color: Colors.grey.shade300,
                                        size: 80.0,
                                      );
                                    },
                                  )
                                : Icon(
                                    Icons.person,
                                    color: Colors.grey.shade300,
                                    size: 80.0,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          buildProfileBox('Id No :', widget.id.toString()),
                          buildProfileBox('Name :', widget.name),
                          buildProfileBox('Email :', widget.email),
                          buildProfileBox('Created At :',
                              widget.created_at.toString().substring(0, 10)),
                          buildProfileBox('Updated At :',
                              widget.updated_at.toString().substring(0, 10)),
                          buildProfileBox('Role :', widget.utype),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: () {
                                deleteConfirmationDialog(
                                    context,
                                    context.read<DeleteUserRoleCubit>(),
                                    widget.id);
                              },
                              style: ThemeHelper().buttonStyle(),
                              child: const Text(
                                'Delete User Account',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                if (isLoading == true)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child:
                          SpinKitFadingCircle(color: Colors.white, size: 50.0),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }

  void deleteConfirmationDialog(
      BuildContext context, DeleteUserRoleCubit cubit, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation!'),
          content:
              const Text('Are you sure you want to delete this user account?'),
          actions: [
            TextButton(
              onPressed: () {
                cubit.deleteUserRole(id);
                setState(() {
                  isLoading = true;
                });
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
