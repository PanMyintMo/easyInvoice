import 'common/ProductListItemResponse.dart';

class GetAllProductResponse {
  final ProductData data;

  GetAllProductResponse({
    required this.data,

  });

  factory GetAllProductResponse.fromJson(Map<String, dynamic> json) {
    return GetAllProductResponse(
      data: ProductData.fromJson(json['data']),

    );
  }
}

class ProductData {
  final int currentPage;
  final List<ProductListItem> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<ProductPageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  ProductData({
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
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      currentPage: json['current_page'],
      data: List<ProductListItem>.from(
        (json['data'] as List<dynamic>).map(
              (item) => ProductListItem.fromJson(item),
        ),
      ),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: List<ProductPageLink>.from(
        (json['links'] as List<dynamic>).map(
              (item) => ProductPageLink.fromJson(item),
        ),
      ),
      nextPageUrl: json['next_page_url'] ?? '',
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'] ?? '',
      to: json['to'],
      total: json['total'],
    );
  }
}

class ProductPageLink {
  final String? url;
  final String label;
  final bool active;

  ProductPageLink({
    required this.url,
    required this.label,
    required this.active,
  });

  factory ProductPageLink.fromJson(Map<String, dynamic> json) {
    return ProductPageLink(
      url: json['url'] != null ? json['url'] : '',
      label: json['label'],
      active: json['active'],
    );
  }
}

