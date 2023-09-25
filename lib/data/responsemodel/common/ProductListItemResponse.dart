class ProductListItem {
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
  final int category_id;
  final String created_at;
  final String updated_at;
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
    required this.sale_price,
    required this.buying_price,
    required this.SKU,
    required this.stock_status,
    required this.feature,
    required this.quantity,
    required this.category_id,
    required this.created_at,
    required this.updated_at,
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
      sale_price: json['sale_price'],
      buying_price: json['buying_price'],
      SKU: json['SKU'],
      stock_status: json['stock_status'],
      feature: json['feature'],
      quantity: json['quantity'],
      category_id: json['category_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      barcode: json['barcode'],
      size_id: json['size_id'],
      url: json['url'],
    );
  }
}
