class ChooseProductOrderRequest{
  final String product_id;
  ChooseProductOrderRequest({required this.product_id});

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
    };
  }

}