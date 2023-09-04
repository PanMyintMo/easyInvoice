class EditRequestModel {
  final String product_id;
  final String quantity;


  EditRequestModel(
      {required this.product_id, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
     'product_id' : product_id,
      'quantity' : quantity
    };
  }
}