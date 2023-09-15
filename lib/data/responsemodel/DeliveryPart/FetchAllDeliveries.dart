import '../CityPart/Cities.dart';

class FetchAllDelivery {
  final int currentPage;
  final List<DeliveriesItem> data;
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

  FetchAllDelivery({
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

  factory FetchAllDelivery.fromJson(Map<String, dynamic> json) {
    return FetchAllDelivery(
      currentPage: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
              ?.map((item) => DeliveriesItem.fromJson(item))
              .toList() ??
          [],
      firstPageUrl: json['data']['first_page_url'],
      from: json['data']['from'],
      lastPage: json['data']['last_page'],
      lastPageUrl: json['data']['last_page_url'],
      links: (json['data']['links'] as List<dynamic>?)
              ?.map((item) => PageLink.fromJson(item))
              .toList() ??
          [],
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



class DeliveriesItem {
  final int company_id;
  final DateTime? start_date;
  final DateTime? end_date;
  final int basic_cost;
  final String waiting_time;
  final String company_type;
  final String? country_name;
  final int country_id; // Change to int
  final int? township_id;
  final String? township_name;
  final int? city_id;
  final String? city_name;

  DeliveriesItem({
    required this.company_id,
    required this.start_date,
    required this.end_date,
    required this.basic_cost,
    required this.waiting_time,
    this.city_id,
    required this.country_id, // Change to int
    this.township_id,
    this.city_name,
    required this.company_type,
    this.country_name,
    this.township_name,
  });

  factory DeliveriesItem.fromJson(Map<String, dynamic> json) {
    return DeliveriesItem(

      start_date: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      end_date: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,

      basic_cost: json['basic_cost'],
      waiting_time: json['waiting_time'],
      company_id: json['company_id'],
      city_id: json['city_id'],
      country_id: json['country_id'],
      township_id: json['township_id'],
      city_name: json['city_name'],
      company_type: json['company_type'],
      country_name: json['country_name'],
      township_name: json['township_name'],
    );
  }
}

