class ShopKeeperRequestModel {
  String category_id;
  String product_id;
  String quantity;

  ShopKeeperRequestModel({required this.category_id, required this.product_id,
    required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'category_id': category_id,
      'product_id' : product_id,
      'quantity' : quantity
    };
  }
}