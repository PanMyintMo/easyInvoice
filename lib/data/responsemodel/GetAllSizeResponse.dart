class GetAllSizeResponse {
  final int id;
  final String name;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;

  GetAllSizeResponse({
    required this.id, required this.name,
    required this.slug, required this.createdAt,
    required this.updatedAt
  });


  factory GetAllSizeResponse.fromJson(Map<String,dynamic> json){
    return GetAllSizeResponse(id: json['id'] as int,
        name: json['name'] as String, slug: json['slug'] as String,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']));
  }
}