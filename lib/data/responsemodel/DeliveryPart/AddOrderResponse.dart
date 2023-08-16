class AddOrderResponse {
  final OrderData orderData;
  final OrderItemData orderItemData;
  final TransactionData transactionData;
  final int status;
  final String message;

  AddOrderResponse({
    required this.orderData,
    required this.orderItemData,
    required this.transactionData,
    required this.status,
    required this.message,
  });

  factory AddOrderResponse.fromJson(Map<String, dynamic> json) {
    return AddOrderResponse(
      orderData: OrderData.fromJson(json['OrderData']),
      orderItemData: OrderItemData.fromJson(json['OrderItemData']),
      transactionData: TransactionData.fromJson(json['TransactionData']),
      status: json['status'],
      message: json['message'],
    );
  }
}

class TransactionData {
  final String user_id;
  final String mode;
  final int order_id;
  final int id;

  TransactionData({
    required this.user_id,
    required this.mode,
    required this.order_id,
    required this.id,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      user_id: json['user_id'],
      mode: json['mode'],
      order_id: json['order_id'],
      id: json['id'],
    );
  }
}

class OrderItemData {
  final String price;
  final String quantity;
  final int order_id;
  final int id;

  OrderItemData({
    required this.price,
    required this.quantity,
    required this.order_id,
    required this.id,
  });

  factory OrderItemData.fromJson(Map<String, dynamic> json) {
    return OrderItemData(
      price: json['price'],
      quantity: json['quantity'],
      order_id: json['order_id'],
      id: json['id'],
    );
  }
}

class OrderData {
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String line1;
  final String line2;
  final String country_id;
  final String city_id;
  final String township_id;
  final String zipcode;
  final String product_id;
  final String user_id;
  final int subtotal;
  final int discount;
  final int tax;
  final int delivery_charge;
  final String delivery_company;
  final String status;
  final int total;
  final String? delivered_date;
  final int id;

  OrderData({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobile,
    required this.line1,
    required this.line2,
    required this.country_id,
    required this.city_id,
    required this.township_id,
    required this.zipcode,
    required this.product_id,
    required this.user_id,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.delivery_charge,
    required this.delivery_company,
    required this.status,
    required this.total,
    required this.delivered_date,
    required this.id,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      mobile: json['mobile'],
      line1: json['line1'],
      line2: json['line2'],
      country_id: json['country_id'],
      city_id: json['city_id'],
      township_id: json['township_id'],
      zipcode: json['zipcode'],
      product_id: json['product_id'],
      user_id: json['user_id'],
      subtotal: json['subtotal'],
      discount: json['discount'],
      tax: json['tax'],
      delivery_charge: json['delivery_charge'],
      total: json['total'],
      delivery_company: json['delivery_company'],
      status: json['status'],
      delivered_date: json['delivered_date'],
      id: json['id'],
    );
  }
}
