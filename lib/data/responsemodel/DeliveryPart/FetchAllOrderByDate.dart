class AllOrderByDateResponse {
  final OrderFilterData data;

  AllOrderByDateResponse({
    required this.data,
  });

  factory AllOrderByDateResponse.fromJson(Map<String, dynamic> json) {
    return AllOrderByDateResponse(
      data: OrderFilterData.fromJson(json['data']),
    );
  }
}

class OrderFilterData {
  final int current_page;
  final List<OrderFilterItem> data;
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

  OrderFilterData({
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

  factory OrderFilterData.fromJson(Map<String, dynamic> json) {
    return OrderFilterData(
      current_page: json['current_page'],
      data: List<OrderFilterItem>.from(json['data'].map((item) => OrderFilterItem.fromJson(item))),
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

class OrderFilterItem {
  final int id;
  final int user_id;
  final String subtotal;
  final String discount;
  final int total;
  final String firstname;
  final String lastname;
  final String tax;
  final String mobile;
  final int delivery_charge;
  final String delivery_company;
  final String line1;
  final String line2;
  final int country_id;
  final int city_id;
  final int township_id;
  final String zipcode;
  final String status;
  final String? delivered_date;
  final String? canceled_date;
  final String created_at;
  final String updated_at;
  final int product_id;

  OrderFilterItem({
    required this.id,required this.user_id,required this.city_id,required this.product_id,required this.status,
    required this.delivery_company,required this.zipcode,required this.township_id,required this.country_id,
    required this.line2,required this.delivery_charge,required this.mobile,
    required this.lastname,required this.firstname,required this.tax,
    required this.discount,required this.subtotal,required this.total,required this.delivered_date,
    required this.line1,required this.created_at,required this.updated_at,required this.canceled_date

  });

  factory OrderFilterItem.fromJson(Map<String, dynamic> json) {
    return OrderFilterItem(id: json['id'], user_id: json['user_id'],
        city_id: json['city_id'],
        product_id: json['product_id'],
        status: json['status'], delivery_company: json['delivery_company'],
        zipcode: json['zipcode'], township_id: json['township_id'],
        country_id: json['country_id'], line2: json['line2'], delivery_charge: json['delivery_charge'], mobile: json['mobile'],
        lastname: json['lastname'], firstname: json['firstname'], tax: json['tax'], discount: json['discount'], subtotal: json['subtotal'],
        total: json['total'], delivered_date: json['delivered_date'],
        line1: json['line1'], created_at: json['created_at'],
        updated_at: json['updated_at'], canceled_date: json['canceled_date']
    );
  }
}
