class ChangeOrderProductQtyRequest {

  final String selectedProductId;
  final String quantity;
  final String sale_price;

  ChangeOrderProductQtyRequest(
      {
      required this.selectedProductId,
      required this.quantity,
      required this.sale_price});

  Map<String, dynamic> toJson() {
    return {
      'selectedProductId': selectedProductId,
      'quantity': quantity,
      'sale_price': sale_price
    };
  }
}
