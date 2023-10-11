import '../PageLink.dart';
import '../common/WardResponse.dart';


class WardResponse {
  final int current_page;
  final List<Ward> data;
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

  WardResponse ({
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

  factory WardResponse.fromJson(Map<String, dynamic> json) {
    return WardResponse (
      current_page: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => Ward.fromJson(item))
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


