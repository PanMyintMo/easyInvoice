class TownshipResponse {
  TownshipResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  final TownshipData data;
  final int status;
  final String message;

  factory TownshipResponse.fromJson(Map<String, dynamic> json) {
    return TownshipResponse(
      data: TownshipData.fromJson(json['data']),
      status: json['status'],
      message: json['message'],
    );
  }
}

class TownshipData {
  TownshipData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final List<Township> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  factory TownshipData.fromJson(Map<String, dynamic> json) {
    return TownshipData(
      currentPage: json['current_page'],
      data: List<Township>.from(json['data'].map((x) => Township.fromJson(x))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: List<Link>.from(json['links'].map((x) => Link.fromJson(x))),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class Township {
  Township({
    required this.id,
    required this.cityId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int cityId;
  final String name;
  final String createdAt;
  final String updatedAt;

  factory Township.fromJson(Map<String, dynamic> json) {
    return Township(
      id: json['id'],
      cityId: json['city_id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String label;
  final bool active;

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}
