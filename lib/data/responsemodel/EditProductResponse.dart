class EditProductResponse {
  final int id;
  final String name;
  final String slug;
  final String short_description;
  final String regular_price;
  final String sale_price;
  final String buying_price;
  final String SKU;
  final String stock_status;
  final int feature;
  final String quantity;
  final String? image;
  final String category_id;
  final String created_at;
  final String updated_at;
  final String? barcode;
  final String size_id;
  final String url;

  EditProductResponse(
      {required this.id,
      required this.name,
      required this.slug,
      required this.short_description,
      required this.regular_price,
      required this.sale_price,
      required this.buying_price,
      required this.SKU,
      required this.stock_status,
      required this.feature,
      required this.quantity,
      required this.image,
      required this.category_id,
      required this.size_id,
      required this.barcode,
      required this.updated_at,
      required this.created_at,
      required this.url});


  factory EditProductResponse.fromJson(Map<String,dynamic> data){
    final productResponse= data['data'] as Map<String,dynamic>;
    return EditProductResponse(id: productResponse['id'], name: productResponse['name'],
        slug: productResponse['slug'], short_description: productResponse['short_description'],
        regular_price: productResponse['regular_price'],
        sale_price: productResponse['sale_price'],
        buying_price: productResponse['buying_price'],
        SKU: productResponse['SKU'], stock_status: productResponse['stock_status'],
        feature: productResponse['feature'], quantity: productResponse['quantity'], image: productResponse['image'],
        category_id: productResponse['category_id'], size_id: productResponse['size_id'], barcode: productResponse['barcode'],
        updated_at: productResponse['updated_at'], created_at: productResponse['created_at'],
        url: productResponse['url']);
  }
}
