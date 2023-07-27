import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post/add_product_cubit.dart';
import '../../module/module.dart';
import '../../widget/OrderPart/AddOrderWidget.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ), title: const Text('Add Order Screen', style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16)),),
        body: BlocBuilder<AddProductCubit, AddProductState>(
          builder: (context, state) {
            if (state is AddProductLoading) {
              return const AddOrderWidget(
                isLoading: true,

              );
            } else if (state is AddProductSuccess) {
              return const AddOrderWidget(
                isLoading: false,
              );
            } else if (state is AddProductFail) {
              return const AddOrderWidget(
                isLoading: false,
              );
            }
            return const AddOrderWidget(
              isLoading: false,
            );
          },
        ),
      ),
    );

  }
}
