class DeliveryManResponse {
  final DeliveryData data;
  final int status;
  final String message;

  DeliveryManResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory DeliveryManResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryManResponse(
      data: DeliveryData.fromJson(json['data']),
      status: json['status'],
      message: json['message'],
    );
  }
}

class DeliveryData {
  final int current_page;
  final String first_page_url;
  final int from;
  final List<DeliveryItemData> data;
  final List<DeliveryLink> links;
  final int last_page;
  final String last_page_url;
  final String? next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int to;
  final int total;

  DeliveryData({
    required this.current_page,
    required this.first_page_url,
    required this.from,
    required this.data,
    required this.links,
    required this.last_page,
    required this.last_page_url,
    required this.next_page_url,
    required this.path,
    required this.per_page,
    required this.prev_page_url,
    required this.to,
    required this.total,
  });

  factory DeliveryData.fromJson(Map<String, dynamic> json) {
    return DeliveryData(
      current_page: json['current_page'],
      links: List<DeliveryLink>.from(json['links'].map((link) => DeliveryLink.fromJson(link))),
      data: List<DeliveryItemData>.from(json['data'].map((item) => DeliveryItemData.fromJson(item))),
      first_page_url: json['first_page_url'],
      from: json['from'],
      last_page: json['last_page'],
      last_page_url: json['last_page_url'],
      next_page_url: json['next_page_url'],
      path: json['path'],
      per_page: json['per_page'],
      prev_page_url: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class DeliveryLink {
  final String? url;
  final String label;
  final bool active;

  DeliveryLink({required this.url, required this.active, required this.label});

  factory DeliveryLink.fromJson(Map<String, dynamic> json) {
    return DeliveryLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}

class DeliveryItemData {
  final int id;
  final int quantity;
  final int product_id;
  final String status;
  final String created_at;
  final String updated_at;
  final String product_name;

  DeliveryItemData({
    required this.id,
    required this.quantity,
    required this.product_id,
    required this.status,
    required this.created_at,
    required this.updated_at,
    required this.product_name,
  });

  factory DeliveryItemData.fromJson(Map<String, dynamic> json) {
    return DeliveryItemData(
      id: json['id'],
      quantity: json['quantity'],
      product_id: json['product_id'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      product_name: json['product_name'] ?? '',
    );
  }
}
