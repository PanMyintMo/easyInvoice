class DeleteProductResponse {
  final int status;
  final String message;

  DeleteProductResponse({required this.status, required this.message});

  factory DeleteProductResponse.fromJson(Map<String, dynamic> json) {
    return DeleteProductResponse(
        status: json['status'], message: json['message']);
  }
}
