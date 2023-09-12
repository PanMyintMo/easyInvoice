class StreetResponse {
  final int currentPage;
  final List<Street> data;
  final String firstPageUrl;
  final int? from;
  final int lastPage;
  final String lastPageUrl;
  final List<PageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int? to;
  final int total;
  final int? status;
  final String? message;

  StreetResponse ({
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
    required this.status,
    required this.message,
  });

  factory StreetResponse.fromJson(Map<String, dynamic> json) {
    return StreetResponse (
      currentPage: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => Street.fromJson(item))
          .toList() ?? [],
      firstPageUrl: json['data']['first_page_url'],
      from: json['data']['from'],
      lastPage: json['data']['last_page'],
      lastPageUrl: json['data']['last_page_url'],
      links: (json['data']['links'] as List<dynamic>?)
          ?.map((item) => PageLink.fromJson(item))
          .toList() ?? [],
      nextPageUrl: json['data']['next_page_url'],
      path: json['data']['path'],
      perPage: json['data']['per_page'],
      prevPageUrl: json['data']['prev_page_url'],
      to: json['data']['to'],
      total: json['data']['total'],
      status: json['status'],
      message: json['message'],
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
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}

class Street {
  final int id;
  final int ward_id;
  final String street_name;
  final String created_at;
  final String? updated_at;

  Street({
    required this.id,
    required this.ward_id,
    required this.street_name,
    required this.created_at,
    this.updated_at,
  });

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      id: json['id'],
      ward_id: json['ward_id'],
      street_name: json['street_name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

}