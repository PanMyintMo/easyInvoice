import 'package:easy_invoice/bloc/delete/delete_product_item_cubit.dart';
import 'package:easy_invoice/data/responsemodel/GetAllProductResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../bloc/edit/edit_product_item_cubit.dart';
import '../bloc/get/get_all_product_cubit.dart';
import '../common/ToastMessage.dart';
import '../module/module.dart';
import '../screen/EditProductItemScreen.dart';

class ProductDetailWidget extends StatefulWidget {
  final ProductListItem products;
  final bool isLoading;

  const ProductDetailWidget({
    Key? key,
    required this.products,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  bool isLoading = false;
  bool isUpdated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (item) => onSelected(context, item),
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
          ),
        ],
        title: const Text(
          'Product Detail Screen',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          color: Colors.redAccent,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<DeleteProductItemCubit, DeleteProductItemState>(
        listener: (context, state) {
          if (state is DeleteProductItemSuccess) {
            showToastMessage('Product item deleted successfully');
            Navigator.pop(context, true); // Pass the result back
          } else if (state is DeleteProductItemFail) {
            showToastMessage('Failed to delete product item: ${state.error}');
          }
        },
        builder: (context, state) {
          isLoading = state is DeleteProductItemLoading;

          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Icon(
                        Icons.production_quantity_limits_outlined,
                        size: 100,
                      ),
                    ),
                    Expanded(child: Text('Product Id: ${widget.products.id}')),
                    Expanded(
                        child: Text('Product Name: ${widget.products.name}')),
                    Expanded(child: Text('Slug Name: ${widget.products.slug}')),
                    Expanded(
                        child: Text(
                            'Stock Status: ${widget.products.stockStatus}')),
                    Expanded(
                        child: Text(
                            'Regular Price: ${widget.products.regular_price}')),
                    Expanded(
                        child:
                            Text('Sale Price: ${widget.products.salePrice}')),
                    Expanded(
                        child: Text(
                            'Buying Price: ${widget.products.buying_price}')),
                    Expanded(
                        child: Text(
                            'Product Quantity: ${widget.products.quantity}')),
                    Expanded(child: Text('SKU: ${widget.products.SKU}')),
                    Expanded(
                        child: Text(
                            'Category Id: ${widget.products.category_id}')),
                    Expanded(
                        child: Text('Size Id: ${widget.products.size_id}')),
                    Expanded(
                        child: Text('Feature: ${widget.products.feature}')),
                    Expanded(
                      child: Text(
                        'Updated At: ${widget.products.updatedAt.substring(0, 10)}',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Created At: ${widget.products.createdAt.substring(0, 10)}',
                      ),
                    ),
                    Expanded(
                        child: Text('Barcode ID: ${widget.products.barcode}')),
                    Expanded(
                      child: Text(
                        'Short Description: ${widget.products.short_description}',
                      ),
                    ),
                    Expanded(
                        child: Text(
                            'Description: ${widget.products.description}')),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void onSelected(BuildContext context, item) async {
    switch (item) {
      case 0:
        final deleteCubit = context.read<DeleteProductItemCubit>();
        showDeleteConfirmationDialog(context, deleteCubit, widget.products);
        break;

      case 1:
        var result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Provider<EditProductItemCubit>(
              create: (_) => EditProductItemCubit(getIt.call()),
              child: EditProductItemScreen(
                  id: widget.products.id,
                  name: widget.products.name,
                  slug: widget.products.slug,
                  short_description: widget.products.short_description,
                  description: widget.products.description,
                  regular_price: widget.products.regular_price,
                  sale_price: widget.products.salePrice,
                  buying_price: widget.products.buying_price,
                  SKU: widget.products.SKU,
                  quantity: widget.products.quantity,
                  category_id: widget.products.category_id,
                  size_id: widget.products.size_id,
                  newimage: ""),
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
                .indexWhere((product) => product.id == widget.products.id);

            if (index != -1) {
              products[index] = result;

            //  getAllProductCubit.updateProductsList(products); // Update the state with the updated list

              setState(() {
                isUpdated = true;
              });
            }
          }
        }

        break;
    }
  }

  void showDeleteConfirmationDialog(
    BuildContext context,
    DeleteProductItemCubit deleteProductItemCubit,
    ProductListItem product,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                // Delete Action
                deleteProductItemCubit.deleteProductItem(product.id);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
