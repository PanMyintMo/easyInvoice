import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../bloc/edit/edit_product_item_cubit.dart';
import '../bloc/get/ProductPart/get_all_product_cubit.dart';
import '../bloc/delete/delete_product_item_cubit.dart';
import '../common/ToastMessage.dart';
import '../common/showDeleteConfirmationDialog.dart';
import '../data/responseModel/common/ProductListItemResponse.dart';
import '../module/module.dart';
import '../widget/ProductDetailWidget.dart';
import 'EditProductItemScreen.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductListItem product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors.red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Product Detail Screen',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          actions: [
            PopupMenuButton(
              onSelected: (item) => onSelected(context, item,product),
              color: Colors.redAccent,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Delete Product'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Edit Product'),
                ),
              ],
            )
          ]),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<DeleteProductItemCubit>(
            create: (context) => DeleteProductItemCubit(getIt.call()),
          ),
          BlocProvider<EditProductItemCubit>(
            create: (_) => EditProductItemCubit(getIt.call()),
          ),
        ],
        child: ProductDetail(product: product),
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final ProductListItem product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteProductItemCubit, DeleteProductItemState>(
      builder: (context, deleteState) {
        bool loading = deleteState is DeleteProductItemLoading;

        return ProductDetailWidget(
          isLoading: loading,
          products: product,
        );
      },
      listener: (context, deleteState) {
        if (deleteState is DeleteProductItemSuccess) {
          showToastMessage('Deleted Product successful.');
          BlocProvider.of<GetAllProductCubit>(context).getAllProduct();
          Navigator.pop(context, true);
        } else if (deleteState is DeleteProductItemFail) {
          showToastMessage(
              'Failed to delete product: ${deleteState.error}');
        }
      },
    );
  }
}

void onSelected(BuildContext context, item, ProductListItem product) async {
  switch (item) {
    case 0:
      showDeleteConfirmationDialogs(
          context, "Are you sure you want to delete this product?", () {
        context.read<DeleteProductItemCubit>().deleteProductItem(product.id);
      });
      break;

    case 1:
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Provider<EditProductItemCubit>(
            create: (_) => EditProductItemCubit(getIt.call()),
            child: EditProductItemScreen(
              id: product.id,
              name: product.name,
              slug: product.slug,
              short_description: product.short_description,
              description: product.description,
              regular_price: product.regular_price,
              sale_price: product.sale_price,
              buying_price: product.buying_price,
              SKU: product.SKU,
              quantity: product.quantity,
              category_id: product.category_id,
              size_id: product.size_id,
              newimage: product.url!,
            ),
          ),
        ),
      );

      if (result != null && result == true) {
        final getAllProductCubit = context.read<GetAllProductCubit>();
        final state = getAllProductCubit.state;

        if (state is GetAllProductSuccess) {
          final products = List.of(state.products);

          // Find the index of the updated product item
          final index = products
              .indexWhere((p) => p.id == product.id);

          if (index != -1) {
            products[index] = result;

          }
        }
      }
      break;
  }
}