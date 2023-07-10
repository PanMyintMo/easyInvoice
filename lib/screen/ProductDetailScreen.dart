import 'package:easy_invoice/bloc/get/get_all_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/delete/delete_product_item_cubit.dart';
import '../bloc/edit/edit_product_item_cubit.dart';
import '../data/responsemodel/GetAllProductResponse.dart';
import '../module/module.dart';
import '../widget/ProductDetailWidget.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductListItem products;
  const ProductDetailScreen({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     bool isLoading= false;
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllProductCubit>(
            create: (_) => GetAllProductCubit(getIt.call())),
        BlocProvider<DeleteProductItemCubit>(
          create: (_) => DeleteProductItemCubit(getIt.call()),
        ),
         BlocProvider<EditProductItemCubit>(
           create: (_) => EditProductItemCubit(getIt.call()),
         ),
      ],
      child: ProductDetailWidget(products: products,isLoading : isLoading),
    );
  }
}
