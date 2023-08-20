class EditShopKeeperRequestModel {
  final String product_id;
  final String quantity;


  EditShopKeeperRequestModel(
      {required this.product_id, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      product_id: 'product_id', quantity: 'quantity'
    };
  }
}