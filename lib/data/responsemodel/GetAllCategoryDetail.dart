class CategoryData {
  List<Category> data;
  CategoryData({
    required this.data,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      data: List<Category>.from(
        json['data'].map((categoryJson) => Category.fromJson(categoryJson)),
      ),
    );
  }
}

class Category {
  int id;
  String name;
  String slug;
  String createdAt;
  String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
