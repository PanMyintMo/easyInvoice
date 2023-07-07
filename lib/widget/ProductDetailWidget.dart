import 'package:easy_invoice/bloc/delete/delete_product_item_cubit.dart';
import 'package:easy_invoice/data/responsemodel/GetAllProductResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/ToastMessage.dart';

class ProductDetailWidget extends StatefulWidget {
  final ProductListItem products;
  final bool isLoading;

  const ProductDetailWidget(
      {Key? key, required this.products, required this.isLoading})
      : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (item) => onSelected(context, item),
            color: Colors.redAccent,
            itemBuilder: (context) =>
            [
              const PopupMenuItem(
                value: 0,
                child: Text('Delete Product'),
              ),
            ],
          ),
        ],
        title: const Text(
          'Detail Product Screen',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          color: Colors.redAccent,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {

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
    if(state is DeleteProductItemLoading){
      isLoading = true;
    }else {
      isLoading = false;
    }

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
              Expanded(child: Text('Product Id : ${widget.products.id}')),
              Expanded(child: Text('Product Name : ${widget.products.name}')),
              Expanded(child: Text('Slug Name : ${widget.products.slug}')),
              Expanded(child: Text('Stock Status: ${widget.products.stockStatus}')),
              Expanded(child: Text('Regular Price : ${widget.products.regularPrice}')),
              Expanded(child: Text('Sale Price : ${widget.products.salePrice}')),
              Expanded(child: Text('Buying price : ${widget.products.buyingPrice}')),
              Expanded(child: Text('Product Quantity : ${widget.products.quantity}')),
              Expanded(child: Text('SKU : ${widget.products.sku}')),
              Expanded(child: Text('Category Id : ${widget.products.categoryId}')),
              Expanded(child: Text('Size Id : ${widget.products.sizeId}')),
              Expanded(child: Text('Feature : ${widget.products.feature}')),
              Expanded(
                child: Text(
                  'Updated At : ${widget.products.updatedAt.substring(0, 10)}',
                ),
              ),
              Expanded(
                child: Text(
                  'Created At : ${widget.products.createdAt.substring(0, 10)}',
                ),
              ),
              Expanded(child: Text('Barcode ID: ${widget.products.barcode}')),
              Expanded(
                child: Text(
                  'Short Description : ${widget.products.shortDescription}',
                ),
              ),
              Expanded(child: Text('Description : ${widget.products.description}')),
            ],
          ),
        ),
          if (isLoading==true)
            Container(
              color: Colors.black54,
              child:  const Center(
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

  void onSelected(BuildContext context, item) {
    switch (item) {
      case 0:
        final deleteCubit = context.read<DeleteProductItemCubit>();
        showDeleteConfirmationDialog(context, deleteCubit, widget.products);
        break;
    }
  }

  void showDeleteConfirmationDialog(BuildContext context,
      DeleteProductItemCubit deleteProductItemCubit,
      ProductListItem product,) {
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
