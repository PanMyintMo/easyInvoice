class CountryResponse {
  final CountryData data;
  CountryResponse({
    required this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
    data: CountryData.fromJson(json['data']),

  );
}

class CountryData {
  CountryData({
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
  final List<Country> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<CountryLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    currentPage: json['current_page'],
    data: List<Country>.from(json['data'].map((x) => Country.fromJson(x))),
    firstPageUrl: json['first_page_url'],
    from: json['from'],
    lastPage: json['last_page'],
    lastPageUrl: json['last_page_url'],
    links: List<CountryLink>.from(json['links'].map((x) => CountryLink.fromJson(x))),
    nextPageUrl: json['next_page_url'],
    path: json['path'],
    perPage: json['per_page'],
    prevPageUrl: json['prev_page_url'],
    to: json['to'],
    total: json['total'],
  );
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json['id'],
    name: json['name'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}

class CountryLink {
  CountryLink({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String label;
  final bool active;

  factory CountryLink.fromJson(Map<String, dynamic> json) => CountryLink(
    url: json['url'],
    label: json['label'],
    active: json['active'],
  );
}
