class FetchAllDelivery  {
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

  FetchAllDelivery  ({
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

  factory FetchAllDelivery .fromJson(Map<String, dynamic> json) {
    return FetchAllDelivery  (
      currentPage: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => DeliveriesItem.fromJson(item))
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

class DeliveriesItem {
  final int id;
  final DateTime? start_date;
  final DateTime? end_date;
  final String state;
  final int basic_cost;
  final String waiting_time;
  final int company_id;
  final String city_id;

  DeliveriesItem({
    required this.id,
    required this.start_date,
    required this.end_date,
    required this.state,
    required this.basic_cost,
    required this.waiting_time,
    required this.company_id,
    required this.city_id,
  });

  factory DeliveriesItem.fromJson(Map<String, dynamic> json) {
    return DeliveriesItem(
      id: json['id'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      state: json['state'],
      basic_cost: json['basic_cost'],
      waiting_time: json['waiting_time'],
      company_id: json['company_id'],
      city_id: json['city_id'],
    );
  }

}