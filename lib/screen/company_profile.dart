import 'package:easy_invoice/bloc/get/CompanyProfile/company_profile_cubit.dart';
import 'package:easy_invoice/widget/CompanyProfilePart/CompanyProfileWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../common/ToastMessage.dart';
import '../module/module.dart';

class CompanyProfile extends StatelessWidget {
  final String username;
  final String email;

  const CompanyProfile({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider<CompanyProfileCubit>(
          create: (context) {
            final cubit = CompanyProfileCubit(
                getIt.call()); // Use getIt<ApiService>() to get the ApiService instance
            cubit.companyProfile(); // call category detail
            return cubit;
          },
        ),

      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(LineAwesomeIcons.angle_left)),
          title: Center(
              child: Text('Company Profile',
                  style: Theme.of(context).textTheme.headlineMedium)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
          ],
        ),
        body: BlocConsumer<CompanyProfileCubit, CompanyProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CompanyProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CompanyProfileFail) {
              showToastMessage(state.error);
            } else if (state is CompanyProfileSuccess) {
              return CompanyProfileWidget(
                user_id: state.companyProfileData.user_id,
                url: state.companyProfileData.url,
                username: username, // Use the correct username from the widget parameter
                email: email, // Use the correct email from the widget parameter
                isLoading: false,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
