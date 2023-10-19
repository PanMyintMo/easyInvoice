import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../bloc/post/Login&Register/edit_company_profile_cubit.dart';
import '../common/ToastMessage.dart';
import '../module/module.dart';
import '../widget/CompanyProfilePart/EditCompanyProfileWidget.dart';

class UpdateCompanyProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String? url;
  final int id;

  const UpdateCompanyProfileScreen(
      {Key? key,
      required this.username,
      required this.email,
      required this.url, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => EditCompanyProfileCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(LineAwesomeIcons.angle_left)),
          title: Text('Edit Profile',
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: BlocBuilder<EditCompanyProfileCubit, EditCompanyProfileState>(
          builder: (context, state) {
            if (state is EditCompanyProfileLoading) {
              return  EditCompanyProfileWidget(isLoading: true, username: username, email: email, id: id,url:url);
            } else if (state is EditCompanyProfileSuccess) {
              showToastMessage("Profile updated successfully!");
              return  EditCompanyProfileWidget(isLoading: false, username: username  , email: email, id: id,url:url);
            }
            else if (state is EditCompanyProfileFail){
              showToastMessage(state.error);
              return  EditCompanyProfileWidget(isLoading: false, username: username, email: email, id: id,url:url)
              ;
            }
            return  EditCompanyProfileWidget(isLoading: false, username: username  , email: email, id: id,url:url);
          },
        ),
      ),
    );
  }
}

