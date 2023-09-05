import 'package:easy_invoice/bloc/delete/delete_product_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../bloc/edit/edit_product_item_cubit.dart';
import '../bloc/get/ProductPart/get_all_product_cubit.dart';
import '../common/ToastMessage.dart';
import '../common/showDeleteConfirmationDialog.dart';
import '../data/responsemodel/common/ProductListItemResponse.dart';
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
        elevation: 0.0,
        backgroundColor: Colors.white24,
        iconTheme: const IconThemeData(
          color: Colors.red, // Set the color of the navigation icon to black
        ),
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
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          color: Colors.redAccent,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    const SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Icon(
                        Icons.production_quantity_limits_outlined,
                        size: 100,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                           const Expanded(child: Text('Product Id: ')),
                          Expanded(child: Text('${widget.products.id}')),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(child: Text('Product Name: ')),
                          Expanded(child: Text(widget.products.name)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(child: Text('Slug Name:')),
                          Expanded(child: Text(widget.products.slug)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                                'Stock Status:'),
                          ),
                          Expanded(
                            child: Text(
                                widget.products.stockStatus),
                          ),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                                'Regular Price:'),
                          ),
                          Expanded(
                            child: Text(
                                widget.products.regular_price),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(child: Text('Sale Price:')),
                          Expanded(child: Text(widget.products.salePrice)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                                'Buying Price: '),
                          ),
                          Expanded(
                            child: Text(
                                widget.products.buying_price),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                                'Product Quantity: '),
                          ),
                          Expanded(
                            child: Text(
                                '${widget.products.quantity}'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(child: Text('SKU: ')),
                          Expanded(child: Text(widget.products.SKU)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                                'Category Id: '),
                          ),
                          Expanded(
                            child: Text(
                                '${widget.products.category_id}'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(child: Text('Size Id: ')),
                          Expanded(child: Text('${widget.products.size_id}')),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                          children: [
                            const Expanded(child: Text('Feature: ')),
                            Expanded(child: Text('${widget.products.feature}')),
                          ],
                        )),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Updated At: ',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.products.updatedAt.substring(0, 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Created At:',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.products.createdAt.substring(0, 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                          children: [
                            const Expanded(child: Text('Barcode ID: ')),
                            Expanded(child: Text('${widget.products.barcode}')),
                          ],
                        )),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Short Description: ',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.products.short_description,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                  'Description: '),
                            ),
                            Expanded(
                              child: Text(
                                  widget.products.description),
                            ),
                          ],
                        )),
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
        showDeleteConfirmationDialogs(context,"Are you sure you want to delete this city?",(){
          context.read<DeleteProductItemCubit>().deleteProductItem(widget.products.id);
        });
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

  // void showDeleteConfirmationDialog(
  //   BuildContext context,
  //   DeleteProductItemCubit deleteProductItemCubit,
  //   ProductListItem product,
  // ) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Confirmation'),
  //         content: const Text('Are you sure you want to delete this product?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               // Delete Action
  //               deleteProductItemCubit.deleteProductItem(product.id);
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Delete'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
