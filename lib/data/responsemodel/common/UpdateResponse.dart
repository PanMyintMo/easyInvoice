class UpdateResponse {
  final UpdateData? data;
  final int status;
  final String message;

  UpdateResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    return UpdateResponse(
      data: json['data'] != null ? UpdateData.fromJson(json['data']) : null,
      status: json['status'],
      message: json['message'],
    );
  }
}

class UpdateData {
  final int id;
  final String name;
  final String slug;
  final String createdAt;
  final String updatedAt;

  UpdateData({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdateData.fromJson(Map<String, dynamic> json) {
    return UpdateData(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
