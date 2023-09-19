import 'package:easy_invoice/common/CardViewProduct.dart';
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
          child: CardViewProduct(
            imageUrl: products.url,
            str1: products.id.toString(),
            str2: products.name.toString(),
            str3: products.slug.toString(),
            str4: products.stockStatus.toString(),
            str5: products.regular_price.toString(),
            str6: products.salePrice.toString(),
            str7: products.buying_price.toString(),
            str8: products.quantity.toString(),
            str9: products.SKU.toString(),
            str10: products.category_id.toString(),
            str11: products.size_id.toString(),
            str12: products.feature.toString(),
            str13: products.updatedAt.substring(0,10).toString(),
            str14: products.createdAt.substring(0,10).toString(),
            str15: products.barcode.toString(),
            str16: products.short_description,
            str17: products.description.toString(),

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
