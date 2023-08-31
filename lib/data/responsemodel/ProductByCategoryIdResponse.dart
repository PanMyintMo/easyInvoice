import 'common/ProductListItemResponse.dart';

class ProductByCategoryIdResponse{

  List<ProductListItem> data;
  ProductByCategoryIdResponse({required this.data});
  
  factory ProductByCategoryIdResponse.fromJson(Map<String,dynamic> json){
    return ProductByCategoryIdResponse(data: List<ProductListItem>.from(json['data'].map((productJson) => ProductListItem.fromJson(productJson)),
       ),
    );
  }
}

