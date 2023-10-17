import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/post/add_size_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/widget/SizeAddFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/ToastMessage.dart';

class SizeAddScreen extends StatefulWidget {
  const SizeAddScreen({Key? key}) : super(key: key);

  @override
  State<SizeAddScreen> createState() => _SizeAddScreenState();
}

class _SizeAddScreenState extends State<SizeAddScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSizeCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            'Sizes Add Screen',
            style: TextStyle(
                color: AdaptiveTheme.of(context).theme.iconTheme.color,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: BlocBuilder<AddSizeCubit, AddSizeState>(
          builder: (context, state) {

            final isLoading= state is AddSizeLoading;
            if (state is AddSizeLoading) {
              return  SizeAddFormWidget(
                isLoading: isLoading,);
            } else if (state is AddSizeSuccess) {
              showToastMessage(state.addSizeResponse.message);
              Navigator.pop(context,true);
              return const SizeAddFormWidget(
                isLoading: false,

              );
            } else if (state is AddSizeFail) {
              showToastMessage(state.error.toString());
              return  SizeAddFormWidget(
                isLoading: isLoading,
              );
            }
            return  SizeAddFormWidget(
              isLoading: isLoading,

            );
          },
        ),
      ),
    );
  }
}
