import 'package:easy_invoice/bloc/post/add_size_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/widget/SizeAddFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocBuilder<AddSizeCubit, AddSizeState>(
          builder: (context, state) {
            if (state is AddSizeLoading) {
              return const SizeAddFormWidget(
                isLoading: true,
                message: '',
              );
            } else if (state is AddSizeSuccess) {
              return SizeAddFormWidget(
                isLoading: false,
                message: state.addSizeResponse.message,
              );
            } else if (state is AddSizeFail) {
              return SizeAddFormWidget(
                isLoading: false,
                message: state.error,
              );
            }
            return const SizeAddFormWidget(
              isLoading: false,
              message: '',
            );
          },
        ),
      ),
    );
  }
}
