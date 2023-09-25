import '../CityPart/Cities.dart';

class FetchAllDelivery {
  final int current_page;
  final List<DeliveriesItem> data;
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

  FetchAllDelivery({
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

  factory FetchAllDelivery.fromJson(Map<String, dynamic> json) {
    return FetchAllDelivery(
      current_page: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
              ?.map((item) => DeliveriesItem.fromJson(item))
              .toList() ??
          [],
      first_page_url: json['data']['first_page_url'],
      from: json['data']['from'],
      last_page: json['data']['last_page'],
      last_page_url: json['data']['last_page_url'],
      links: (json['data']['links'] as List<dynamic>?)
              ?.map((item) => PageLink.fromJson(item))
              .toList() ??
          [],
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



class DeliveriesItem {
  final int delivery_info_id;
  final int basic_cost;
  final String waiting_time;
  final int company_id;
  final String company_name;
  final String url;
  final int country_id;
  final String? country_name;
  final DateTime? start_date;
  final DateTime? end_date;
  final int? township_id;
  final String? township_name;
  final int? city_id;
  final String? city_name;


  DeliveriesItem( {
   required this.company_name,
    required this.delivery_info_id,
    required this.url,
    required this.company_id,
    required this.start_date,
    required this.end_date,
    required this.basic_cost,
    required this.waiting_time,
    this.city_id,
    required this.country_id, // Change to int
    this.township_id,
    this.city_name,
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

      country_name: json['country_name'],
      township_name: json['township_name'],
      delivery_info_id: json['delivery_info_id'],
      url: json['url'], company_name: json['company_name'],
    );
  }
}

