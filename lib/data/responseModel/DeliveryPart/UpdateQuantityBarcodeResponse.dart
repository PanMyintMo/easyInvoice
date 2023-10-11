import 'ProductInvoiceResponse.dart';

class UpdateQuantityBarcodeResponse {
  final InvoiceData data;
  final String status;
  final String message;

  UpdateQuantityBarcodeResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory UpdateQuantityBarcodeResponse.fromJson(Map<String, dynamic> json) {
    return UpdateQuantityBarcodeResponse(
      data: InvoiceData.fromJson(json['data']),
      status: json['status'],
      message: json['message'],
    );
  }
}
