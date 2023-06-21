import 'package:easy_invoice/bloc/get/get_all_user_role_cubit.dart';
import 'package:easy_invoice/screen/UserDetailProfileScren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/responsemodel/UserRoleResponse.dart';
import '../module/module.dart';

class AllUserRoleWidget extends StatelessWidget {
  final List<UserData> userData;

  const AllUserRoleWidget({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetAllUserRoleCubit(getIt.call()),
        child: Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('All User Role')),
              backgroundColor: Colors.redAccent
                  .withOpacity(0.8), // Customize the background color here
            ),
            body: ListView.builder(
              itemCount: userData.length,
              itemBuilder: (BuildContext context, int index) {
                UserData user = userData[index];
                return ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: user.profilePhotoUrl.isNotEmpty
                        ? Image.network(
                      user.profilePhotoUrl,
                      scale: 1.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          color: Colors.grey.shade300,
                          size: 50.0,
                        );
                      },
                    )
                        : Icon(
                      Icons.person,
                      color: Colors.grey.shade300,
                      size: 50.0,
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  subtitle: Text(
                    'Role: ${user.utype}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.yellow),
                  ),
                  trailing: CustomButton(
                    label: 'View Detail Profile',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailProfileScreen(
                            id: user.id,
                            name: user.name,
                            email: user.email,
                            created_at: user.createdAt,
                            updated_at: user.updatedAt,
                            utype: user.utype,
                            profileImageUrl: user.profilePhotoUrl,
                          ),
                        ),
                      );
                    },
                  ),
                );
                },
            )
        )
    );
  }


}

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  CustomButton({Key? key, required this.label, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(); // Invoke the provided callback function
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .colorScheme
                .primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
