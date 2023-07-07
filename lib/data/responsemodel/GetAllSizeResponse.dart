class GetAllSizeResponse {
  final SizeData data;

  GetAllSizeResponse({
    required this.data,
  });

  factory GetAllSizeResponse.fromJson(Map<String, dynamic> json) {
    return GetAllSizeResponse(
      data: SizeData.fromJson(json['data']),
    );
  }
}

class SizeData {
  final int current_page;
  final List<SizeItems> data;
  final String first_page_url;
  final int from;
  final int last_page;
  final String last_page_url;
  final List<SizePageLink> links;
  final String next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int to;
  final int total;

  SizeData({
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

  factory SizeData.fromJson(Map<String, dynamic> json) {
    return SizeData(
      current_page: json['current_page'],
      data: List<SizeItems>.from(json['data'].map((item) => SizeItems.fromJson(item))),
      first_page_url: json['first_page_url'],
      from: json['from'],
      last_page: json['last_page'],
      last_page_url: json['last_page_url'],
      links: List<SizePageLink>.from(json['links'].map((item) => SizePageLink.fromJson(item))),
      next_page_url: json['next_page_url'] ?? '',
      path: json['path'],
      per_page: json['per_page'],
      prev_page_url: json['prev_page_url'] ?? '',
      to: json['to'],
      total: json['total'],
    );
  }

}

class SizePageLink {
  final String? url;
  final String label;
  final bool active;

  SizePageLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory SizePageLink.fromJson(Map<String, dynamic> json) {
    return SizePageLink(
      url: json['url'] != null ? json['url'] : '',
      label: json['label'],
      active: json['active'],
    );
  }
}

class SizeItems {
  final int id;
  final String name;
  final String slug;
  final DateTime created_at;
  final DateTime updated_at;

  SizeItems({
    required this.id,
    required this.name,
    required this.slug,
    required this.created_at,
    required this.updated_at,
  });

  factory SizeItems.fromJson(Map<String, dynamic> json) {
    return SizeItems(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
    );
  }
}
