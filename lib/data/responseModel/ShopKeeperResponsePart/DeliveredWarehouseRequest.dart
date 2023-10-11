class DeliveryWarehouseResponse {
  final DeliveryWarehouseData data;

  DeliveryWarehouseResponse({
    required this.data,
  });

  factory DeliveryWarehouseResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryWarehouseResponse(
      data: DeliveryWarehouseData.fromJson(json['data']),
    );
  }
}

class DeliveryWarehouseData {
  final int current_page;
  final List<DeliveryWarehouseItem> data;
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

  DeliveryWarehouseData({
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

  factory DeliveryWarehouseData.fromJson(Map<String, dynamic> json) {
    return DeliveryWarehouseData(
      current_page: json['current_page'],
      data: List<DeliveryWarehouseItem>.from(json['data'].map((item) => DeliveryWarehouseItem.fromJson(item))),
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

class DeliveryWarehouseItem {
  final int id;
  final int quantity;
  final int product_id;
  final String status;
  final String product_name;

  DeliveryWarehouseItem({
    required this.id,
    required this.quantity,
    required this.product_id,
    required this.status,
    required this.product_name,
  });

  factory DeliveryWarehouseItem.fromJson(Map<String, dynamic> json) {
    return DeliveryWarehouseItem(
      id: json['id'],
      quantity: json['quantity'],
      product_id: json['product_id'],
      status: json['status'],
      product_name: json['product_name'],
    );
  }
}
