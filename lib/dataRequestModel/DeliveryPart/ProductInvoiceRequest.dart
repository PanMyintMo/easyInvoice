class ProductInvoiceRequest{
  final String barcode;
  ProductInvoiceRequest({required this.barcode});
  Map<String,dynamic> toJson() {
    return{
      'barcode' : barcode
    };
  }
}