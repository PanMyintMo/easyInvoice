class EditProductRequestModel {
  final String name;
  final String slug;
  final String short_description;
  final String description;
  final String regular_price;
  final String sale_price;
  final String buying_price;
  final String SKU;
  final String quantity;
  final String category_id;
  final String size_id;
  final String? newimage;

  EditProductRequestModel(
      {required this.name,
      required this.slug,
      required this.short_description,
      required this.description,
      required this.regular_price,
      required this.sale_price,
      required this.buying_price,
      required this.SKU,
      required this.quantity,
      required this.category_id,
      required this.size_id,
      required this.newimage});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'short_description': short_description,
      'description': description,
      'regular_price': regular_price,
      'sale_price': sale_price,
      'buying_price' : buying_price,
      'SKU': SKU,
      'quantity': quantity,
      'category_id': category_id,
      'size_id': size_id,
      'newimage': newimage ?? ''
    };
  }
}
