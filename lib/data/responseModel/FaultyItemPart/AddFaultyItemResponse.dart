class AddFaultyItemResponse {
  final FaultyData data;
  final int status;
  final String message;

  AddFaultyItemResponse(
      {required this.data, required this.status, required this.message});

  factory AddFaultyItemResponse.fromJson(Map<String, dynamic> json) {
    return AddFaultyItemResponse(
        data: FaultyData.fromJson(json['data']),
        status: json['status'],
        message: json['message']);
  }
}

class FaultyData {
  final String quantity;
  final String product_id;
  final String product_name;
  final String updated_at;
  final String created_at;
  final int id;

  FaultyData(
      {required this.quantity,
      required this.product_id,
        required this.product_name,
      required this.updated_at,
      required this.created_at,
      required this.id});

  factory FaultyData.fromJson(Map<String, dynamic> json) {
    return FaultyData(
        quantity: json['quantity'],
        product_id: json['product_id'],
        product_name: json['product_name'],
        updated_at: json['updated_at'],
        created_at: json['created_at'],
        id: json['id']);
  }
}
