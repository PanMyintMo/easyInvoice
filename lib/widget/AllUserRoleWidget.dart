import 'package:easy_invoice/bloc/get/get_all_user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/CustomButtom.dart';
import '../data/responsemodel/UserRoleResponse.dart';
import '../screen/UserDetailProfileScren.dart';

class AllUserRoleWidget extends StatelessWidget {
  final List<UserData> userData;
  final bool isLoading;
  final String message;

  const AllUserRoleWidget({
    Key? key,
    required this.userData,
    required this.isLoading,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('All User Role')),
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (BuildContext context, int index) {
          UserData user = userData[index];
          return ListTile(
            leading: SizedBox(
              width: 60,
              height: 60,
              child: user.url != null && user.url!.isNotEmpty
                  ? Image.network(
                user.url!,
                scale: 1.0,
                width: 50,
                height: 50,
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            subtitle: Text(
              'Role: ${user.utype}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            trailing: CustomButton(
              label: 'View Detail Profile',
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailProfileScreen(
                      id: user.id,
                      name: user.name,
                      email: user.email,
                      created_at: user.createdAt,
                      updated_at: user.updatedAt,
                      utype: user.utype,
                      url: user.url.toString(),
                    ),
                  ),
                );
                if (result != null && result == true) {
                  context.read<GetAllUserRoleCubit>().getAllUserRole();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
