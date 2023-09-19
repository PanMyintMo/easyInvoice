class EditOrderData {
  final int id;
  final String userId;
  final int customerId;
  final int addressId;
  final String productId;
  final String? description;
  final String subtotal;
  final String discount;
  final String tax;
  final int total;
  final int deliveryCharge;
  final String deliveryCompany;
  final String status;
  final String deliveredDate;
  final String? canceledDate;
  final String createdAt;
  final String updatedAt;

  EditOrderData({
    required this.id,
    required this.userId,
    required this.customerId,
    required this.addressId,
    required this.productId,
    this.description,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.total,
    required this.deliveryCharge,
    required this.deliveryCompany,
    required this.status,
    required this.deliveredDate,
    this.canceledDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EditOrderData.fromJson(Map<String, dynamic> json) {
    return EditOrderData(
      id: json['OrderData']['id'],
      userId: json['OrderData']['user_id'],
      customerId: json['CustomerInfo']['id'],
      addressId: json['AddressInfo']['id'],
      productId: json['OrderData']['product_id'],
      description: json['OrderData']['description'],
      subtotal: json['OrderData']['subtotal'],
      discount: json['OrderData']['discount'],
      tax: json['OrderData']['tax'],
      total: json['OrderData']['total'],
      deliveryCharge: json['OrderData']['delivery_charge'],
      deliveryCompany: json['OrderData']['delivery_company'],
      status: json['OrderData']['status'],
      deliveredDate: json['OrderData']['delivered_date'],
      canceledDate: json['OrderData']['canceled_date'],
      createdAt: json['OrderData']['created_at'],
      updatedAt: json['OrderData']['updated_at'],
    );
  }
}

class CustomerInfo {
  final int id;
  final String firstname;
  final String lastname;
  final String mobile;
  final String line1;
  final String line2;
  final String email;
  final String createdAt;
  final String updatedAt;

  CustomerInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.line1,
    required this.line2,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      id: json['CustomerInfo']['id'],
      firstname: json['CustomerInfo']['firstname'],
      lastname: json['CustomerInfo']['lastname'],
      mobile: json['CustomerInfo']['mobile'],
      line1: json['CustomerInfo']['line1'],
      line2: json['CustomerInfo']['line2'],
      email: json['CustomerInfo']['email'],

      createdAt: json['CustomerInfo']['created_at'],
      updatedAt: json['CustomerInfo']['updated_at'],
    );
  }
}

class AddressInfo {
  final int customerId;
  final String streetId;
  final int addType;
  final String blockNo;
  final String floor;
  final String zipcode;
  final String updatedAt;
  final String createdAt;
  final int id;

  AddressInfo({
    required this.customerId,
    required this.streetId,
    required this.addType,
    required this.blockNo,
    required this.floor,
    required this.zipcode,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) {
    return AddressInfo(
      customerId: json['AddressInfo']['customer_id'],
      streetId: json['AddressInfo']['street_id'],
      addType: json['AddressInfo']['add_type'],
      blockNo: json['AddressInfo']['block_no'],
      floor: json['AddressInfo']['floor'],
      zipcode: json['AddressInfo']['zipcode'],
      updatedAt: json['AddressInfo']['updated_at'],
      createdAt: json['AddressInfo']['created_at'],
      id: json['AddressInfo']['id'],
    );
  }
}

class OrderItemData {
  final int id;
  final int orderId;
  final String price;
  final String quantity;
  final String createdAt;
  final String updatedAt;
  final int rstatus;
  final String options;

  OrderItemData({
    required this.id,
    required this.orderId,
    required this.price,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.rstatus,
    required this.options,
  });

  factory OrderItemData.fromJson(Map<String, dynamic> json) {
    return OrderItemData(
      id: json['OrderItemData']['id'],
      orderId: json['OrderItemData']['order_id'],
      price: json['OrderItemData']['price'],
      quantity: json['OrderItemData']['quantity'],
      createdAt: json['OrderItemData']['created_at'],
      updatedAt: json['OrderItemData']['updated_at'],
      rstatus: json['OrderItemData']['rstatus'],
      options: json['OrderItemData']['options'],
    );
  }
}

class TransactionData {
  final int id;
  final String userId;
  final int orderId;
  final String mode;
  final String createdAt;
  final String updatedAt;
  final String? image;
  final String? url;

  TransactionData({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.mode,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    this.url,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['TransactionData']['id'],
      userId: json['TransactionData']['user_id'],
      orderId: json['TransactionData']['order_id'],
      mode: json['TransactionData']['mode'],
      createdAt: json['TransactionData']['created_at'],
      updatedAt: json['TransactionData']['updated_at'],
      image: json['TransactionData']['image'],
      url: json['TransactionData']['url'],
    );
  }
}
