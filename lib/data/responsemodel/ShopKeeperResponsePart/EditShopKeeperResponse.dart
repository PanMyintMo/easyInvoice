class EditShopKeeperResponse {

  final ShopKeeperUpdatedData data;
  final int status;
  final String message;

  EditShopKeeperResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditShopKeeperResponse.fromJson(Map<String, dynamic> json) {
    return EditShopKeeperResponse(
      status: json['status'],
      message: json['message'],
      data: ShopKeeperUpdatedData.fromJson(json['data']),
    );
  }
}

class ShopKeeperUpdatedData {
  final int id;
  final String quantity;
  final String product_id;
  final String status;
  final String product_name;

  ShopKeeperUpdatedData({
    required this.id,
    required this.quantity,
    required this.product_id,
    required this.product_name,
    required this.status,
  });

  factory ShopKeeperUpdatedData.fromJson(Map<String, dynamic> json) {
    return ShopKeeperUpdatedData(
      id: json['id'],
      quantity: json['quantity'],
      product_id: json['product_id'],
      product_name: json['product_name'],
      status: json['status'],
    );
  }
}
