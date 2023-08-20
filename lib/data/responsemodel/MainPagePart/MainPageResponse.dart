class OrderApiResponse {
  final List<OrderData> data;
  final int totalProfit;
  final int totalSales;
  final int totalRevenue;
  final int shopKeeper;
  final int totalWareHouseQuantity;
  final String totalFaultyItem;
  final int status;
  final String message;

  OrderApiResponse({
    required this.data,
    required this.totalProfit,
    required this.totalSales,
    required this.totalRevenue,
    required this.shopKeeper,
    required this.totalWareHouseQuantity,
    required this.totalFaultyItem,
    required this.status,
    required this.message,
  });

  factory OrderApiResponse.fromJson(Map<String, dynamic> json) {
    return OrderApiResponse(
      data: (json['data'] as List).map((item) => OrderData.fromJson(item)).toList(),
      totalProfit: json['totalProfit'],
      totalSales: json['totalSales'],
      totalRevenue: json['totalRevenue'],
      shopKeeper: json['shopKeeper'],
      totalWareHouseQuantity: json['totalWareHouseQuantity'],
      totalFaultyItem: json['totalFaultyItem'],
      status: json['status'],
      message: json['message'],
    );
  }
}

class OrderData {
  final int id;
  final int userId;
  final String subtotal;
  final String discount;
  final String tax;
  final int total;
  final String firstname;
  final String lastname;
  final String mobile;
  final String email;
  final int deliveryCharge;
  final String deliveryCompany;
  final String line1;
  final String line2;
  final int countryId;
  final int cityId;
  final int townshipId;
  final String zipcode;
  final String status;
  final int productId;

  OrderData({
    required this.id,
    required this.userId,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.total,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.email,
    required this.deliveryCharge,
    required this.deliveryCompany,
    required this.line1,
    required this.line2,
    required this.countryId,
    required this.cityId,
    required this.townshipId,
    required this.zipcode,
    required this.status,

    required this.productId,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      userId: json['user_id'],
      subtotal: json['subtotal'],
      discount: json['discount'],
      tax: json['tax'],
      total: json['total'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      mobile: json['mobile'],
      email: json['email'],
      deliveryCharge: json['delivery_charge'],
      deliveryCompany: json['delivery_company'],
      line1: json['line1'],
      line2: json['line2'],
      countryId: json['country_id'],
      cityId: json['city_id'],
      townshipId: json['township_id'],
      zipcode: json['zipcode'],
      status: json['status'],
      productId: json['product_id'],
    );
  }
}