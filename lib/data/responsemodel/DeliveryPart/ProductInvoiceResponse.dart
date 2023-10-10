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
    return ProductInvoiceResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((invoice) => InvoiceData.fromJson(invoice))
          .toList() ??
          [],
      status: json['status'],
      message: json['message'], // Corrected field name
    );
  }
}

class InvoiceData {
  final int? id;
  final int? product_id;
  final String? created_at;
  final String? updated_at;
  int? quantity;
  int? total;
  final String? product_name;
  final String ?sale_price;
  final String? user_id;

  InvoiceData({
    required this.id,
    required this.product_id,
    required this.created_at,
    required this.updated_at,
    required this.quantity,
    required this.total,
    required this.product_name,
    required this.sale_price,
    required this.user_id,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      id: json['id'],
      product_id: json['product_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      quantity: json['quantity'],
      total: json['total'],
      product_name: json['product_name'],
      sale_price: json['sale_price'],
      user_id: json['user_id'],
    );
  }
}
