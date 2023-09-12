class WardResponse {
  final int currentPage;
  final List<Ward> data;
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

  WardResponse ({
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

  factory WardResponse.fromJson(Map<String, dynamic> json) {
    return WardResponse (
      currentPage: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => Ward.fromJson(item))
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

class Ward {
  final int id;
  final int state_id;
  final String ward_name;
  final String created_at;
  final String? updated_at;

  Ward({
    required this.id,
    required this.state_id,
    required this.ward_name,
    required this.created_at,
    this.updated_at,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['id'],
      state_id: json['state_id'],
      ward_name: json['ward_name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}