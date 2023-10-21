import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/post/ProductPart/add_product_cubit.dart';
import 'package:easy_invoice/common/ToastMessage.dart';
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
        appBar: AppBar(
          iconTheme:  IconThemeData(
            color:AdaptiveTheme.of(context).theme.iconTheme.color, // Set the color of the navigation icon to black
          ), title:  Text('Add Product', style: TextStyle(
              color: AdaptiveTheme.of(context).theme.iconTheme.color,

            fontSize: 16)),),
        body: BlocBuilder<AddProductCubit, AddProductState>(
          builder: (context, state) {
            final isLoading= state is AddProductLoading;

            if (state is AddProductLoading) {

              return  AddProductWidget(
                 isLoading: isLoading,

              );
            } else if (state is AddProductSuccess) {
              showToastMessage(state.addProductResponse.message);
              Navigator.pop(context,true);
              return  AddProductWidget(
                isLoading: isLoading,

              );
            } else if (state is AddProductFail) {
              return  AddProductWidget(
                isLoading: isLoading,

              );
            }
            return  AddProductWidget(
               isLoading: isLoading,

            );
          },
        ),
      ),
    );
  }
}
