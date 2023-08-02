import 'package:easy_invoice/bloc/post/ProductPart/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../module/module.dart';
import '../widget/AddProductWidget.dart';


class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(elevation: 0.0,
          backgroundColor: Colors.white24,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ), title: const Text('Add Product', style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16)),),
        body: BlocBuilder<AddProductCubit, AddProductState>(
          builder: (context, state) {
            if (state is AddProductLoading) {
              return const AddProductWidget(
                 isLoading: true,
                 message: '',
              );
            } else if (state is AddProductSuccess) {
              return AddProductWidget(
                isLoading: false,
                message: state.addProductResponse.message,
              );
            } else if (state is AddProductFail) {
              return AddProductWidget(
                isLoading: false,
                message: state.error,
              );
            }
            return const AddProductWidget(
               isLoading: false,
               message: '',
            );
          },
        ),
      ),
    );
  }
}
