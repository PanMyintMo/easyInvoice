class OrderByDateResponse {
  final int currentPage;
  final List<OrderFilterItem> data;
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

  OrderByDateResponse({
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

  factory OrderByDateResponse.fromJson(Map<String, dynamic> json) {
    return OrderByDateResponse(
      currentPage: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => OrderFilterItem.fromJson(item))
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

class OrderFilterItem {
  final int id;
  final int userId;
  final String subtotal;
  final String discount;
  final int total;
  final String firstname;
  final String lastname;
  final String tax;
  final String mobile;
  final int deliveryCharge;
  final String deliveryCompany;
  final String line1;
  final String line2;
  final int countryId;
  final int cityId;
  final int townshipId;
  final String zipcode;
  final String status;
  final String? deliveredDate;
  final String? canceledDate;
  final String createdAt;
  final String updatedAt;
  final int productId;

  OrderFilterItem({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.productId,
    required this.status,
    required this.deliveryCompany,
    required this.zipcode,
    required this.townshipId,
    required this.countryId,
    required this.line2,
    required this.deliveryCharge,
    required this.mobile,
    required this.lastname,
    required this.firstname,
    required this.tax,
    required this.discount,
    required this.subtotal,
    required this.total,
    required this.deliveredDate,
    required this.line1,
    required this.createdAt,
    required this.updatedAt,
    required this.canceledDate,
  });

  factory OrderFilterItem.fromJson(Map<String, dynamic> json) {
    return OrderFilterItem(
      id: json['id'],
      userId: json['user_id'],
      cityId: json['city_id'],
      productId: json['product_id'],
      status: json['status'],
      deliveryCompany: json['delivery_company'],
      zipcode: json['zipcode'],
      townshipId: json['township_id'],
      countryId: json['country_id'],
      line2: json['line2'],
      deliveryCharge: json['delivery_charge'],
      mobile: json['mobile'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      tax: json['tax'],
      discount: json['discount'],
      subtotal: json['subtotal'],
      total: json['total'],
      deliveredDate: json['delivered_date'],
      line1: json['line1'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      canceledDate: json['canceled_date'],
    );
  }
}
