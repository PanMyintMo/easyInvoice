class ChooseProductOrderResponse {
  final String sale_price;
  final int available_quantity;
  final int status;
  final String message;

  ChooseProductOrderResponse({
    required this.sale_price,
    required this.available_quantity,
    required this.status,
    required this.message,
  });

  factory ChooseProductOrderResponse.fromJson(Map<String, dynamic> data) {
    return ChooseProductOrderResponse(
      sale_price: data['sale_price'],
      available_quantity: data['available_quantity'],
      status: data['status'],
      message: data['message'],
    );
  }
}
