class ProductListItem {
  final int id;
  final String name;
  final String slug;
  final String short_description;
  final String description;
  final String regular_price;
  final String salePrice;
  final String buying_price;
  final String SKU;
  final String stockStatus;
  final int feature;
  final int quantity;
  final String? image;
  final int category_id;
  final String createdAt;
  final String updatedAt;
  final dynamic barcode;
  final int size_id;
  final String? url;

  ProductListItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.short_description,
    required this.description,
    required this.regular_price,
    required this.salePrice,
    required this.buying_price,
    required this.SKU,
    required this.stockStatus,
    required this.feature,
    required this.quantity,
    required this.image,
    required this.category_id,
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.size_id,
    required this.url,
  });

  factory ProductListItem.fromJson(Map<String, dynamic> json) {
    return ProductListItem(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      short_description: json['short_description'],
      description: json['description'],
      regular_price: json['regular_price'],
      salePrice: json['sale_price'],
      buying_price: json['buying_price'],
      SKU: json['SKU'],
      stockStatus: json['stock_status'],
      feature: json['feature'],
      quantity: json['quantity'],
      image: json['image'],
      category_id: json['category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      barcode: json['barcode'],
      size_id: json['size_id'],
      url: json['url'],
    );
  }
}
