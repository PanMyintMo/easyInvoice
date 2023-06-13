class CategoryData {
  final int id;
  final String name;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryData({
    required this.id, required this.name,
    required this.slug, required this.createdAt,
    required this.updatedAt
  });


  factory CategoryData.fromJson(Map<String,dynamic> json){
    return CategoryData(id: json['id'] as int,
        name: json['name'] as String, slug: json['slug'] as String,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']));
  }

}