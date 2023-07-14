class AddShopKeeperResponse{
  String product_id;
  String quantity;
  String updated_at;
  String created_at;
  int id;

  AddShopKeeperResponse({required this.product_id, required this.quantity, required this.created_at,
  required this.updated_at,required this.id});
  factory AddShopKeeperResponse.fromJson(Map<String,dynamic> data)  {
    final dataJson= data['data'] as Map<String, dynamic>;
    return AddShopKeeperResponse(product_id: dataJson['product_id'],
        quantity:dataJson ['quantity'], created_at: dataJson['created_at'],
        updated_at: dataJson['updated_at'], id: dataJson['id']);

  }

}