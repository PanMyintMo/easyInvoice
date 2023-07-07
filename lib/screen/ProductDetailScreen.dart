import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/delete/delete_product_item_cubit.dart';
import '../bloc/edit/edit_category_cubit.dart';
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
        BlocProvider<DeleteProductItemCubit>(
          create: (_) => DeleteProductItemCubit(getIt.call()),
        ),
        BlocProvider<EditCategoryCubit>(
          create: (_) => EditCategoryCubit(getIt.call()),
        ),
      ],
      child: ProductDetailWidget(products: products,isLoading : isLoading),
    );
  }
}
