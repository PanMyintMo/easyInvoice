import '../PageLink.dart';

class CountryResponse {
  final int current_page;
  final List<Country> data;
  final String first_page_url;
  final int from; // Change from int? to int
  final int last_page;
  final String last_page_url;
  final List<PageLink> links;
  final String? next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int to; // Change from int? to int
  final int total;
  final int status; // Change from int? to int
  final String message; // Change from String? to String

  CountryResponse({
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
    required this.status,
    required this.message,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      current_page: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => Country.fromJson(item))
          .toList() ?? [],
      first_page_url: json['data']['first_page_url'],
      from: json['data']['from'],
      last_page: json['data']['last_page'],
      last_page_url: json['data']['last_page_url'],
      links: (json['data']['links'] as List<dynamic>?)
          ?.map((item) => PageLink.fromJson(item))
          .toList() ?? [],
      next_page_url: json['data']['next_page_url'],
      path: json['data']['path'],
      per_page: json['data']['per_page'],
      prev_page_url: json['data']['prev_page_url'],
      to: json['data']['to'],
      total: json['data']['total'],
      status: json['status'],
      message: json['message'],
    );
  }
}

class Country {
  final int id;
  final String name;
  final String? created_at;
  final String? updated_at;

  Country({
  required this.id,
  required this.name,
  required this.created_at,
  required this.updated_at,
});

factory Country.fromJson(Map<String, dynamic> json) => Country(
id: json['id'],
name: json['name'],
created_at: json['created_at'],
updated_at: json['updated_at'],
);
}


