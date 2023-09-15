import '../CityPart/Cities.dart';

class ShopProductListResponse {
  final ShopProductList data;

  ShopProductListResponse({required this.data});

  factory ShopProductListResponse.fromJson(Map<String, dynamic> json) {
    return ShopProductListResponse(
      data: ShopProductList.fromJson(json['data']),
    );
  }
}

class ShopProductList {
  final int current_page;
  final List<ShopProductItem> data;
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

  ShopProductList({
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

  factory ShopProductList.fromJson(Map<String, dynamic> json) {
    return ShopProductList(
      current_page: json['current_page'],
      data: List<ShopProductItem>.from(
          json['data'].map((item) => ShopProductItem.fromJson(item))),
      first_page_url: json['first_page_url'],
      from: json['from'],
      last_page: json['last_page'],
      last_page_url: json['last_page_url'],
      links: List<PageLink>.from(
          json['links'].map((item) => PageLink.fromJson(item))),
      next_page_url: json['next_page_url'] ?? '',
      path: json['path'],
      per_page: json['per_page'],
      prev_page_url: json['prev_page_url'] ?? '',
      to: json['to'],
      total: json['total'],
    );
  }
}


class ShopProductItem {
  final int id;
  final int product_id;
  final int quantity;
  final String product_name;

  ShopProductItem({
    required this.id,
    required this.product_id,
    required this.quantity,
    required this.product_name,
  });

  factory ShopProductItem.fromJson(Map<String, dynamic> json) {
    return ShopProductItem(
      id: json['id'],
      product_id: json['product_id'],
      quantity: json['quantity'],
      product_name: json['product_name'],
    );
  }
}
