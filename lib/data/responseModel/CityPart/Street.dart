import '../PageLink.dart';
import '../common/WardResponse.dart';

class StreetResponse {
  final int current_page;
  final List<Street> data;
  final String first_page_url;
  final int? from;
  final int last_page;
  final String last_page_url;
  final List<PageLink> links;
  final String? next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int? to;
  final int total;
  final int? status;
  final String? message;

  StreetResponse ({
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

  factory StreetResponse.fromJson(Map<String, dynamic> json) {
    return StreetResponse (
      current_page: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => Street.fromJson(item))
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



class Street {
  final int id;
  final int ward_id;
  final String street_name;
  final String? created_at;
  final String? updated_at;
  final Ward ward;

  Street({
    required this.id,
    required this.ward_id,
    required this.street_name,
    required this.created_at,
    this.updated_at,
    required this.ward,
  });

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      id: json['id'],
      ward_id: json['ward_id'],
      street_name: json['street_name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      ward: Ward.fromJson(json['ward']),
    );
  }
}