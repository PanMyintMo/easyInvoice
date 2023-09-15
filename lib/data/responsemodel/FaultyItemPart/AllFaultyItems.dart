import '../CityPart/Cities.dart';
import '../ShopKeeperResponsePart/ShopKeeperRequestResponse.dart';

class AllFaultyItemsResponse  {
  final int currentPage;
  final List<FaultyItemData> data;
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

  AllFaultyItemsResponse ({
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

  factory AllFaultyItemsResponse .fromJson(Map<String, dynamic> json) {
    return AllFaultyItemsResponse (
      currentPage: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => FaultyItemData.fromJson(item))
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



class FaultyItemData  {
  final int id;
  final int quantity;
  final int product_id;
  final String created_at;
  final String updated_at;
  final String product_name;
  final Product productListData;


  FaultyItemData({
    required this.id,
    required this.quantity,
    required this.created_at,
    required this.updated_at,
    required this.product_id,
    required this.product_name,
    required this.productListData
  });

  factory FaultyItemData.fromJson(Map<String, dynamic> json) {
    return FaultyItemData(
        id: json['id'],
        quantity: json['quantity'],
        product_id: json['product_id'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        product_name: json['product_name'],
      productListData: Product.fromJson(json['product'])
    );
  }
}


