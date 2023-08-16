class UpdateQuantityBarcodeRequest{
  final String quantity;
  final String invoice_id;

  UpdateQuantityBarcodeRequest({required this.quantity,required this.invoice_id});

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'invoice_id': invoice_id
    };
  }
}