class WarehouseResponse{
  final List<WarehouseData> data;
  final int status;
  final String message;

  WarehouseResponse( {required this.data,required this.status,required this.message,});
  factory WarehouseResponse.fromJson(Map<String, dynamic> json) => WarehouseResponse(
      data: (json['data'] as List).map((item) => WarehouseData.fromJson(item)).toList(), status: json['status'], message: json['message'],
    );
}

class WarehouseData {

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
  final int quantity;
  final int category_id;
  final int size_id;
  final String barcode;
  final String? url;
  WarehouseData({required this.id,required this.name,required this.slug,
  required this.short_description,required this.description,
  required this.regular_price,required this.sale_price,required this.buying_price,
  required this.SKU,required this.stock_status,required this.quantity,
  required this.category_id,required this.size_id,required this.barcode,required this.url});

  factory WarehouseData.fromJson(Map<String,dynamic> json){
    return WarehouseData(id: json['id'], name: json['name'],
        slug: json['slug'], short_description: json['short_description'],
        description: json['description'], regular_price: json['regular_price'],
        sale_price: json['sale_price'], buying_price: json['buying_price'], SKU: json['SKU'],
        stock_status: json['stock_status'], quantity: json['quantity'], category_id: json['category_id'],
        size_id: json['size_id'], barcode: json['barcode'], url: json['url']
    );
  }
}