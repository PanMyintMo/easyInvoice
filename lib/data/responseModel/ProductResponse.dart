class ProductResponse{

  String name;
  String slug;
  String short_description;
  String description;
  String regular_price;
  String sale_price;
  String buying_price;
  String SKU;
  String quantity;
  String category_id;
  String size_id;
  String updated_at;
  String created_at;
  int id;
  int status;
  String message;

  ProductResponse({required this.name,
  required this.slug,required this.short_description,
  required this.description,required this.regular_price,required this.sale_price,
  required this.buying_price, required this.SKU, required this.quantity,required this.category_id,
  required this.size_id,required this.updated_at,required this.created_at,
  required this.id,required this.status,required this.message});


  factory ProductResponse.fromJson(Map<String,dynamic> data){
    final dataResponse=data['data'] as Map<String, dynamic>;

    return ProductResponse(name: dataResponse['name'], slug: dataResponse['slug'],
        short_description: dataResponse['short_description'], description: dataResponse['description'], regular_price: dataResponse['regular_price'], sale_price: dataResponse['sale_price'], buying_price: dataResponse['buying_price'], SKU: dataResponse['SKU'], quantity: dataResponse['quantity'], category_id: dataResponse['category_id'], size_id: dataResponse['size_id'], updated_at: dataResponse['updated_at'], created_at: dataResponse['created_at'], id: dataResponse['id'], status: data['status'], message: data ['message']);
  }
}