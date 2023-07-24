class CategoryDataResponse {
  final CategoryData data;

  CategoryDataResponse({
    required this.data,
  });

  factory CategoryDataResponse.fromJson(Map<String, dynamic> json) {
    return CategoryDataResponse(
      data: CategoryData.fromJson(json['data']),
    );
  }
}

class CategoryData {
  final int current_page;
  final List<CategoryItem> data;
  final String first_page_url;
  final int from;
  final int last_page;
  final String last_page_url;
  final List<PageLink> links;
  final String next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int to;
  final int total;

  CategoryData({
    required this.current_page,
    required this.data,
    required this.first_page_url,
    required this.from,
    required this.last_page,
    required this.last_page_url,
    required this.links,
    required this.next_page_url,
    required this.path,
    required this.per_page,
    required this.prev_page_url,
    required this.to,
    required this.total,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      current_page: json['current_page'],
      data: List<CategoryItem>.from(json['data'].map((item) => CategoryItem.fromJson(item))),
      first_page_url: json['first_page_url'],
      from: json['from'],
      last_page: json['last_page'],
      last_page_url: json['last_page_url'],
      links: List<PageLink>.from(json['links'].map((item) => PageLink.fromJson(item))),
      next_page_url: json['next_page_url'] ?? '',
      path: json['path'],
      per_page: json['per_page'],
      prev_page_url: json['prev_page_url'] ?? '',
      to: json['to'],
      total: json['total'],
    );
  }

}

class PageLink {
  final String? url;
  final String label;
  final bool active;

  PageLink({
     this.url,
    required this.label,
    required this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'] != null ? json['url'] : '',
      label: json['label'],
      active: json['active'],
    );
  }
}

class CategoryItem {
  final int id;
  final String name;
  final String slug;
  final DateTime created_at;
  final DateTime updated_at;

  CategoryItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.created_at,
    required this.updated_at,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
    );
  }
}
