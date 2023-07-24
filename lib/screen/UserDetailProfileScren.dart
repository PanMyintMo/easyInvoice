import 'package:easy_invoice/bloc/delete/delete_user_role_cubit.dart';
import 'package:easy_invoice/common/ThemeHelperUserClass.dart';
import 'package:easy_invoice/screen/UpdateUserRoleScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/edit/edit_user_role_cubit.dart';
import '../bloc/get/get_all_user_role_cubit.dart';
import '../common/HeaderWidget.dart';
import '../common/ToastMessage.dart';
import '../common/theme_helper.dart';
import '../module/module.dart';

class UserDetailProfileScreen extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String created_at;
  final String updated_at;
  final String utype;
  final String url;

  const UserDetailProfileScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.email,
    required this.created_at,
    required this.updated_at,
    required this.utype,
    required this.url,
  }) : super(key: key);

  @override
  State<UserDetailProfileScreen> createState() =>
      _UserDetailProfileScreenState();
}

class _UserDetailProfileScreenState extends State<UserDetailProfileScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllUserRoleCubit>(
          create: (context) {
            final cubit = GetAllUserRoleCubit(getIt.call());
            cubit.getAllUserRole();
            return cubit;
          },
        ),
        BlocProvider<DeleteUserRoleCubit>(
          create: (context) => DeleteUserRoleCubit(getIt.call()),
        ),
        BlocProvider<EditUserRoleCubit>(
          create: (context) => EditUserRoleCubit(getIt.call()),
        ),
      ],
      child: Builder(builder: (context) {
        BlocProvider.of<GetAllUserRoleCubit>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.redAccent.withOpacity(0.3),
                    Colors.pink.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
            title: const Center(
              child: Text(
                'User Role Detail Profile',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateUserRoleScreen(
                        id: widget.id,
                        name: widget.name,
                        password: '',
                        utype: widget.utype,
                        email: widget.email,
                        newimage: widget.url,
                      ),
                    ),
                  );

                  if (result == true) {
                    // Refresh the user detail screen
                    BlocProvider.of<GetAllUserRoleCubit>(context)
                        .getAllUserRole();
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: BlocConsumer<DeleteUserRoleCubit, DeleteUserRoleState>(
            listener: (context, state) {
              if (state is DeleteUserRoleLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is DeleteUserRoleSuccess) {
                showToastMessage('User account deleted successfully',
                    duration: 3000);
                Navigator.pop(
                    context, true); // Return a result to previous page
              } else if (state is DeleteUserRoleFail) {
                showToastMessage('Failed to delete user account',
                    duration: 3000);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all( color: Colors.white24),
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
                                child: widget.url.isNotEmpty
                                    ? Image.network(
                                        widget.url,
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          // Display a fallback icon if the image fails to load
                                          return Icon(
                                            Icons.person,
                                            color: Colors.grey.shade300,
                                            size: 130.0,
                                          );
                                        },
                                      )
                                    : Icon(
                                        Icons.person,
                                        color: Colors.grey.shade300,
                                        size: 130.0,
                                      ),
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
                            buildProfileBox(
                              'Created At :',
                              widget.created_at.toString().substring(0, 10),
                            ),
                            buildProfileBox(
                              'Updated At :',
                              widget.updated_at.toString().substring(0, 10),
                            ),
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
                                    widget.id,
                                  );
                                },
                                style: ThemeHelper().buttonStyle(),
                                child: const Text(
                                  'Delete Account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isLoading)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      }),
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
                Navigator.pop(context); // Close the dialog
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
