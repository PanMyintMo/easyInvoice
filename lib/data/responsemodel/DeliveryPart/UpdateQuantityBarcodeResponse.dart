class UpdateQuantityBarcodeResponse {
  final UpdateQuantity data;
  final String status;
  final String message;

  UpdateQuantityBarcodeResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory UpdateQuantityBarcodeResponse.fromJson(Map<String, dynamic> json) {
    return UpdateQuantityBarcodeResponse(
      data: UpdateQuantity.fromJson(json['data']),
      status: json['status'],
      message: json['message'],
    );
  }
}

class UpdateQuantity {
  final int id;
  final int product_id;
  final int quantity;
  final int total;
  final String product_name;
  final String sale_price;
  final String user_id;

  UpdateQuantity({
    required this.id,
    required this.product_id,
    required this.quantity,
    required this.total,
    required this.product_name,
    required this.sale_price,
    required this.user_id,
  });

  factory UpdateQuantity.fromJson(Map<String, dynamic> json) {
    return UpdateQuantity(
      id: json['id'],
      product_id: json['product_id'],
      quantity: json['quantity'],
      total: json['total'],
      product_name: json['product_name'],
      sale_price: json['sale_price'],
      user_id: json['user_id'],
    );
  }
}


