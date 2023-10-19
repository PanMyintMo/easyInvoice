import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../network/SharedPreferenceHelper.dart';
import '../../screen/home/Login.dart';
import '../../screen/profile_menu.dart';
import '../../screen/update_company_profile.dart';

class CompanyProfileWidget extends StatefulWidget {
  final int user_id;
  final String? url;
  final bool isLoading;
  final String username;
  final String email;

  const CompanyProfileWidget({
    Key? key,
    required this.user_id,
    required this.url,
    required this.username,
    required this.email,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<CompanyProfileWidget> createState() => _CompanyProfileWidgetState();
}

class _CompanyProfileWidgetState extends State<CompanyProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 55,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: widget.url != null && widget.url!.isNotEmpty
                        ? Image.network(widget.url!)
                        : const Icon(
                      Icons.account_circle_rounded,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(widget.username,
                style: Theme.of(context).textTheme.headlineMedium),
            Text(widget.email, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),

            /// -- BUTTON
            SizedBox(
              width: 200,
             child: ElevatedButton(
                onPressed: () => Get.to(() => UpdateCompanyProfileScreen(
                    username: widget.username,
                    email: widget.email,
                    url: widget.url ?? '',
                    id: widget.user_id)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text('Edit Profile',
                    style: TextStyle(color: Colors.black38)),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            /// -- MENU
            ProfileMenuWidget(
                title: "Settings",
                icon: LineAwesomeIcons.cog,
                iconColor: Colors.redAccent,
                onPress: () {}),
            ProfileMenuWidget(
                title: "Billing Details",
                icon: LineAwesomeIcons.wallet,
                iconColor: Colors.redAccent,
                onPress: () {}),
            ProfileMenuWidget(
                title: "User Management",
                icon: LineAwesomeIcons.user_check,
                iconColor: Colors.redAccent,
                onPress: () {}),
            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuWidget(
                title: "Information",
                icon: LineAwesomeIcons.info,
                iconColor: Colors.redAccent,
                onPress: () {}),
            ProfileMenuWidget(
              title: "Logout",
              icon: LineAwesomeIcons.alternate_sign_out,
              iconColor: Colors.red,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                Get.defaultDialog(
                  title: "LOGOUT",
                  titleStyle: const TextStyle(fontSize: 20),
                  content: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("Are you sure you want to Logout?"),
                  ),
                  confirm: ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => const Login());
                      SessionManager().removeAuthToken();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      side: BorderSide.none,
                    ),
                    child: const Text("Yes"),
                  ),
                  cancel: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text("No"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
