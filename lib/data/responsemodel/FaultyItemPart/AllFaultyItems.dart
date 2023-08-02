class AllFaultyItemsResponse {
  final FaultyDatas data;
  final int status;
  final String message;

  AllFaultyItemsResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory AllFaultyItemsResponse.fromJson(Map<String, dynamic> json) {
    return AllFaultyItemsResponse(
      data: FaultyDatas.fromJson(json['data']),
      status: json['status'],
      message: json['message'],
    );
  }
}

class FaultyDatas {
  final int current_page;
  final String first_page_url;
  final int from;
  final List<FaultyItemData> data;
  final List<FaultyLinks> links; // Changed 'link' to 'links'
  final int last_page;
  final String last_page_url;
  final String? next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int to;
  final int total;

  FaultyDatas({
    required this.current_page,
    required this.first_page_url,
    required this.from,
    required this.data,
    required this.links, // Changed 'link' to 'links'
    required this.last_page,
    required this.last_page_url,
    required this.next_page_url,
    required this.path,
    required this.per_page,
    required this.prev_page_url,
    required this.to,
    required this.total,
  });

  factory FaultyDatas.fromJson(Map<String, dynamic> json) {
    return FaultyDatas(
      current_page: json['current_page'],
      links: List<FaultyLinks>.from(
          json['links'].map((link) => FaultyLinks.fromJson(link))),
      data: List<FaultyItemData>.from(
          json['data'].map((item) => FaultyItemData.fromJson(item))),
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

class FaultyLinks {
  final String? url;
  final String label;
  final bool active;

  FaultyLinks({required this.url, required this.active, required this.label});

  factory FaultyLinks.fromJson(Map<String, dynamic> json) {
    return FaultyLinks(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}

class FaultyItemData {
  final int id;
  final int quantity;
  final int product_id;
  final String created_at;
  final String updated_at;
  final String product_name;

  FaultyItemData({
    required this.id,
    required this.quantity,
    required this.created_at,
    required this.updated_at,
    required this.product_id,
    required this.product_name
  });

  factory FaultyItemData.fromJson(Map<String, dynamic> json) {
    return FaultyItemData(
      id: json['id'],
      quantity: json['quantity'],
      product_id: json['product_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      product_name: json['product_name']
    );
  }
}
