class FetchAllDelivery {
  final DeliveriesData data;

  FetchAllDelivery({
    required this.data,
  });

  factory FetchAllDelivery.fromJson(Map<String, dynamic> json) {
    return FetchAllDelivery(
      data: DeliveriesData.fromJson(json['data']),
    );
  }
}

class DeliveriesData {
  final int current_page;
  final List<DeliveriesItem> data;
  final String first_page_url;
  final int from;
  final int last_page;
  final String last_page_url;
  final List<PageLink> links;
  final String next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int to;
  final int total;

  DeliveriesData({
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
  });

  factory DeliveriesData.fromJson(Map<String, dynamic> json) {
    return DeliveriesData(
      current_page: json['current_page'],
      data: List<DeliveriesItem>.from(json['data'].map((item) => DeliveriesItem.fromJson(item))),
      first_page_url: json['first_page_url'],
      from: json['from'],
      last_page: json['last_page'],
      last_page_url: json['last_page_url'],
      links: List<PageLink>.from(json['links'].map((item) => PageLink.fromJson(item))),
      next_page_url: json['next_page_url'] ?? '',
      path: json['path'],
      per_page: json['per_page'],
      prev_page_url: json['prev_page_url'] ?? '',
      to: json['to'],
      total: json['total'],
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
      url: json['url'] != null ? json['url'] : '',
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
