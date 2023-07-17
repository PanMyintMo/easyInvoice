class ProductByCategoryIdResponse{

  List<ProductItem> data;
  ProductByCategoryIdResponse({required this.data});
  
  factory ProductByCategoryIdResponse.fromJson(Map<String,dynamic> json){
    return ProductByCategoryIdResponse(data: List<ProductItem>.from(json['data'].map((productJson) => ProductItem.fromJson(productJson)),
       ),
    );
  }
}

class ProductItem {
  final int id;
  final String name;
  final String slug;
  final String short_description;
  final String description;
  final String regular_price;
  final String sale_price;
  final String buying_price;
  final String SKU;
  final String stock_status;
  final int feature;
  final int quantity;
  final String? image;
  final int category_id;
  final String created_at;
  final String updated_at;
  final String? barcode;
  final int size_id;
  final String? url;

  ProductItem({required this.id,required this.name,required this.slug,
  required this.short_description,required this.description, required this.regular_price,
  required this.sale_price,required this.buying_price,required this.SKU,
  required this.stock_status,required this.feature,
    required this.quantity, this.image,
  required this.category_id,required this.created_at,
    required this.updated_at,this.barcode,this.url,required this.size_id});

  factory ProductItem.fromJson(Map<String,dynamic> json){
    return ProductItem(id: json['id'], name: json['name'],
        slug: json['slug'], short_description: json['short_description'],
        description: json['description'], regular_price: json['regular_price'],
        sale_price: json['sale_price'], buying_price: json['buying_price'],
        SKU: json['SKU'],
        barcode: json['barcode'],
        stock_status: json['stock_status'], feature: json['feature'],
        quantity: json['quantity'],
        image: json['image'], category_id: json['category_id'],
        created_at: json['created_at'], updated_at: json['updated_at'],
        url: json['url'], size_id: json['size_id']);
  }
}
