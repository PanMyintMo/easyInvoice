class ProductInvoiceResponse {
  final List<InvoiceData> data;
  final String status;
  final String message;

  ProductInvoiceResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ProductInvoiceResponse.fromJson(Map<String, dynamic> json) {
    var data = json['data'] as List;
    List<InvoiceData> invoiceDataList =
    data.map((e) => InvoiceData.fromJson(e)).toList();

    return ProductInvoiceResponse(
      data: invoiceDataList,
      status: json['status'],
      message: json['messege'],
    );
  }
}

class InvoiceData {
  final int id;
  final int productId;
  final String createdAt;
  final String updatedAt;
  int quantity;
  int total;
  final String productName;
  final String salePrice;
  final String userId;

  InvoiceData({
    required this.id,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.quantity,
    required this.total,
    required this.productName,
    required this.salePrice,
    required this.userId,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      id: json['id'],
      productId: json['product_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      quantity: json['quantity'],
      total: json['total'],
      productName: json['product_name'],
      salePrice: json['sale_price'],
      userId: json['user_id'],
    );
  }
}
