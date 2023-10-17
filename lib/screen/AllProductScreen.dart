import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/delete/delete_product_item_cubit.dart';
import 'package:easy_invoice/bloc/get/ProductPart/get_all_product_cubit.dart';
import 'package:easy_invoice/screen/AddProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/ToastMessage.dart';
import '../module/module.dart';
import '../widget/AllProductWidget.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(
            'All Product  Screen',
            style: TextStyle(
                color:AdaptiveTheme.of(context).theme.iconTheme.color,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<GetAllProductCubit>(
            create: (context) {
              final cubit = GetAllProductCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.getAllProduct();
              return cubit;
            },
          ),
          BlocProvider<DeleteProductItemCubit>(
            create: (context) => DeleteProductItemCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const ProductScreen()));
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProductScreen(),
                ),
              );
              if (result == true) {
                BlocProvider.of<GetAllProductCubit>(context).getAllProduct();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Add Product',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<GetAllProductCubit, GetAllProductState>(
            builder: (context, state) {
              if (state is GetAllProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetAllProductSuccess) {
                final products = state.products;

                if (products.isEmpty) {
                  return const Center(
                    child: Text("No Product Data found."),
                  );
                }

                return BlocConsumer<DeleteProductItemCubit, DeleteProductItemState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteProductItemLoading;

                    return AllProductWidget(isLoading: loading, products: state.products,);
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteProductItemSuccess) {
                      showToastMessage('Deleted Product successful.');
                      BlocProvider.of<GetAllProductCubit>(context)
                          .getAllProduct();
                    } else if (deleteState is DeleteProductItemFail) {
                      showToastMessage(
                          'Failed to delete product: ${deleteState.error}');
                    }
                  },
                );
              } else {
                return const SizedBox(); // Handle other states if needed
              }
            },
          ),
        ),
      ],
    );
  }
}






