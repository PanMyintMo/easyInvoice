class ShopKeeperRequestResponse {
  final List<ShopRequestData> data;
  final int status;
  final String message;

  ShopKeeperRequestResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ShopKeeperRequestResponse.fromJson(Map<String, dynamic> json) {
    return ShopKeeperRequestResponse(
      data: List<ShopRequestData>.from(
        json['data'].map((shopData) => ShopRequestData.fromJson(shopData)),
      ),
      status: json['status'],
      message: json['message'],
    );
  }
}

class ShopRequestData {
  final int id;
  final int quantity;
  final int product_id;
  final String status;
  final String product_name;
  final Product productData;

  ShopRequestData({
    required this.id,
    required this.quantity,
    required this.product_id,
    required this.status,
    required this.product_name,
    required this.productData,
  });

  factory ShopRequestData.fromJson(Map<String, dynamic> json) {
    return ShopRequestData(
      id: json['id'],
      quantity: json['quantity'],
      product_id: json['product_id'],
      status: json['status'],
      product_name: json['product_name'],
      productData: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final int category_id;

  Product({
    required this.id,
    required this.name,
    required this.category_id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category_id: json['category_id'],
    );
  }
}
