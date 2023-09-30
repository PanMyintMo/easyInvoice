class ChangeOrderQtyResponse {
  final int? total;
  final String? sale_price;
  final int available_quantity;
  final int status;
  final String message;

  ChangeOrderQtyResponse({
    required this.total,
    required this.sale_price,
    required this.available_quantity,
    required this.status,
    required this.message,
  });

  factory ChangeOrderQtyResponse.fromJson(Map<String, dynamic> json) {
    return ChangeOrderQtyResponse(
      total: json['total'] ?? 0,
      sale_price: json['sale_price'],
      available_quantity: json['available_quantity'] ?? 0,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
