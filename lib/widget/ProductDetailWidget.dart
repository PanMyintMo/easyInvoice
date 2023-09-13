import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../data/responsemodel/common/ProductListItemResponse.dart';


class ProductDetailWidget extends StatelessWidget {
  final ProductListItem products;
  final bool isLoading;

  const ProductDetailWidget({
    Key? key,
    required this.products,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text('Product Id: ')),
                    Expanded(child: Text('${products.id}')),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Product Name: ')),
                    Expanded(child: Text(products.name)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Slug Name:')),
                    Expanded(child: Text(products.slug)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Stock Status:'),
                    ),
                    Expanded(
                      child: Text(products.stockStatus),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Regular Price:'),
                    ),
                    Expanded(
                      child: Text(products.regular_price),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Sale Price:')),
                    Expanded(child: Text(products.salePrice)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Buying Price: '),
                    ),
                    Expanded(
                      child: Text(products.buying_price),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Product Quantity: '),
                    ),
                    Expanded(
                      child: Text('${products.quantity}'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('SKU: ')),
                    Expanded(child: Text(products.SKU)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Category Id: '),
                    ),
                    Expanded(
                      child: Text('${products.category_id}'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Size Id: ')),
                    Expanded(child: Text('${products.size_id}')),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Feature: ')),
                    Expanded(child: Text('${products.feature}')),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Updated At: ',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        products.updatedAt.substring(0, 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Created At:',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        products.createdAt.substring(0, 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(child: Text('Barcode ID: ')),
                    Expanded(child: Text('${products.barcode}')),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Short Description: ',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        products.short_description,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Description: '),
                    ),
                    Expanded(
                      child: Text(products.description),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                products.image != null
                    ? Image.network(
                        products.url!,
                        width: MediaQuery.of(context).size.width,
                        height: 150.0,
                  fit: BoxFit.scaleDown,
                      )
                    : const SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Icon(
                          Icons.production_quantity_limits_outlined,
                          size: 150,
                        ),
                      )
              ],
            ),
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
  }
}
