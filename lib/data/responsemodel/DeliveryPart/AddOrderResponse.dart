class OrderResponse {
  final Customer customer;
  final Address address;
  final OrderData orderData;
  final OrderItemData orderItemData;
  final TransactionData transactionData;
  final int status;
  final String message;

  OrderResponse({
    required this.customer,
    required this.address,
    required this.orderData,
    required this.orderItemData,
    required this.transactionData,
    required this.status,
    required this.message,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      customer: Customer.fromJson(json['customer'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
      orderData: OrderData.fromJson(json['orderData'] ?? {}),
      orderItemData: OrderItemData.fromJson(json['orderItemData'] ?? {}),
      transactionData: TransactionData.fromJson(json['transactionData'] ?? {}),
      status: json['status'],
      message: json['message'],
    );
  }
}

class Customer {
  final int id;
  final String firstname;
  final String lastname;
  final String mobile;
  final String line1;
  final String line2;
  final String email;
  final String created_at;
  final String updated_at;

  Customer({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.line1,
    required this.line2,
    required this.email,
    required this.created_at,
    required this.updated_at,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? 0,
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      mobile: json['mobile'] ?? '',
      line1: json['line1'] ?? '',
      line2: json['line2'] ?? '',
      email: json['email'] ?? '',
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
    );
  }
}

class Address {
  final int customer_id;
  final String firstname;
  final String lastname;
  final String mobile;
  final String line1;
  final String line2;
  final String email;
  final int address_id;
  final int street_id;
  final int add_type;
  final String block_no;
  final String floor;
  final String zipcode;
  final int ward_id;
  final String street_name;
  final int state_id;
  final String ward_name;
  final int city_id;
  final String state_name;
  final int country_id;
  final String city_name;
  final String country_name;

  Address({
    required this.customer_id,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.line1,
    required this.line2,
    required this.email,
    required this.address_id,
    required this.street_id,
    required this.add_type,
    required this.block_no,
    required this.floor,
    required this.zipcode,
    required this.ward_id,
    required this.street_name,
    required this.state_id,
    required this.ward_name,
    required this.city_id,
    required this.state_name,
    required this.country_id,
    required this.city_name,
    required this.country_name,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      customer_id: json['customer_id'] ?? 0,
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      mobile: json['mobile'] ?? '',
      line1: json['line1'] ?? '',
      line2: json['line2'] ?? '',
      email: json['email'] ?? '',
      address_id: json['address_id'] ?? 0,
      street_id: json['street_id'] ?? 0,
      add_type: json['add_type'] ?? 0,
      block_no: json['block_no'] ?? '',
      floor: json['floor'] ?? '',
      zipcode: json['zipcode'] ?? '',
      ward_id: json['ward_id'] ?? 0,
      street_name: json['street_name'] ?? '',
      state_id: json['state_id'] ?? 0,
      ward_name: json['ward_name'] ?? '',
      city_id: json['city_id'] ?? 0,
      state_name: json['state_name'] ?? '',
      country_id: json['country_id'] ?? 0,
      city_name: json['city_name'] ?? '',
      country_name: json['country_name'] ?? '',
    );
  }
}

class OrderData {
  final int id;
  final String user_id;
  final int customer_id;
  final int address_id;
  final String product_id;
  final String delivery_info_id;
  final String? description;
  final String subtotal;
  final String discount;
  final String tax;
  final int total;
  final int delivery_charge;
  final String status;
  final String updated_at;
  final String created_at;

  OrderData({
    required this.delivery_info_id,
    required this.customer_id,
    required this.address_id,
    required this.product_id,
    required this.user_id,
    this.description,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.delivery_charge,
    required this.status,
    required this.total,
    required this.updated_at,
    required this.created_at,
    required this.id,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      customer_id: json['customer_id'] ?? 0,
      address_id: json['address_id'] ?? 0,
      product_id: json['product_id'] ?? '',
      user_id: json['user_id'] ?? '',
      description: json['description'] ?? '',
      subtotal: json['subtotal'] ?? '',
      discount: json['discount'] ?? '',
      tax: json['tax'] ?? '',
      delivery_charge: json['delivery_charge'] ?? 0,
      // Default value added
      status: json['status'] ?? '',
      // Default value added
      total: json['total'] ?? 0,
      delivery_info_id: json['delivery_info_id'] ?? '',
      updated_at: json['updated_at'] ?? '',
      created_at: json['created_at'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}

class OrderItemData {
  final String price;
  final String quantity;
  final int order_id;
  final String updated_at;
  final String created_at;
  final int id;

  OrderItemData({
    required this.price,
    required this.quantity,
    required this.order_id,
    required this.updated_at,
    required this.created_at,
    required this.id,
  });

  factory OrderItemData.fromJson(Map<String, dynamic> json) {
    return OrderItemData(
      price: json['price'] ?? '',
      quantity: json['quantity'] ?? '',
      order_id: json['order_id'] ?? 0,
      updated_at: json['updated_at'] ?? '',
      created_at: json['created_at'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}

class TransactionData {
  final String user_id;
  final String mode;
  final int order_id;
  final String updated_at;
  final String created_at;
  final int id;

  TransactionData({
    required this.user_id,
    required this.mode,
    required this.order_id,
    required this.updated_at,
    required this.created_at,
    required this.id,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      user_id: json['user_id'] ?? '',
      mode: json['mode'] ?? '',
      order_id: json['order_id'] ?? 0,
      updated_at: json['updated_at'] ?? '',
      created_at: json['created_at'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}
