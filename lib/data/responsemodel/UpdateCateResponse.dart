class CategoryUpdateResponse {
  final CategoryUpdateData? data;
  final int status;
  final String message;

  CategoryUpdateResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory CategoryUpdateResponse.fromJson(Map<String, dynamic> json) {
    return CategoryUpdateResponse(
      data: json['data'] != null ? CategoryUpdateData.fromJson(json['data']) : null,
      status: json['status'],
      message: json['message'],
    );
  }
}

class CategoryUpdateData {
  final int id;
  final String name;
  final String slug;
  final String createdAt;
  final String updatedAt;

  CategoryUpdateData({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryUpdateData.fromJson(Map<String, dynamic> json) {
    return CategoryUpdateData(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
