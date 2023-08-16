class ChangeOrderQtyResponse {
  final int total;
  final int availableQuantity;
  final int status;
  final String message;

  ChangeOrderQtyResponse({
    required this.total,
    required this.availableQuantity,
    required this.status,
    required this.message,
  });

  factory ChangeOrderQtyResponse.fromJson(Map<String, dynamic> json) {
    return ChangeOrderQtyResponse(
      total: json['total'] ?? 0,
      availableQuantity: json['available quantity'] ?? 0,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
