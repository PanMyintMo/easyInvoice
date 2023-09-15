class OrderApiResponse {
  final List<OrderData> data;
  final int totalProfit;
  final int totalSales;
  final String totalRevenue;
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
      data: (json['data'] as List)
          .map((item) => OrderData.fromJson(item))
          .toList(),
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
  final int order_id;
  final int user_id;
  final int customer_id;
  final int address_id;
  final String subtotal;
  final String discount;
  final String tax;
  final int total;
  final int delivery_charge;
  final String delivery_company;
  final String status;
  final int product_id;
  final String price;
  final int quantity;
  final int orderitem_id;
  final int transaction_id;
  final String transaction_mode;
  final String name;
  final String slug;
  final String short_description;
  final String product_description;
  final String regular_price;
  final String sale_price;
  final String buying_price;
  final String SKU;
  final String stock_status;
  final int product_quantity;
  final int category_id;
  final String firstname;
  final String lastname;
  final String mobile;
  final String line1;
  final String line2;
  final String email;
  final int street_id;
  final int add_type;
  final String block_no;
  final String floor;
  final String zipcode;
  final int ward_id;
  final String ward_name;
  final int city_id;
  final String state_name;
  final int country_id;
  final String city_name;
  final String country_name;


  OrderData({
   required this.order_id,required this.user_id,
    required this.quantity,required this.price,
    required this.product_id, required this.zipcode,required this.floor,
    required this.block_no,required this.line2,required this.line1,
    required this.mobile,required this.lastname,required this.firstname,
    required this.country_id,required this.ward_name,required this.country_name,
    required this.city_name,required this.ward_id,required this.street_id,required this.email,
    required this.sale_price,required this.category_id,required this.SKU,required this.buying_price,
    required this.regular_price,required this.short_description,required this.slug,
    required this.name,required this.customer_id,required this.status,
    required this.delivery_company,required this.total,required this.subtotal,
    required this.discount,required this.tax,required this.delivery_charge,
    required this.city_id,required this.stock_status,required this.add_type,
    required this.address_id,required this.orderitem_id,required this.product_description,
    required this.product_quantity,required this.state_name,required this.transaction_id,required this.transaction_mode ,

  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order_id: json['order_id'],
      user_id: json['user_id'],
      quantity: json['quantity'],
      price: json['price'],
      product_id: json['product_id'],
      zipcode: json['zipcode'],
      floor: json['floor'],
      block_no: json['block_no'],
      line2: json['line2'],
      line1: json['line1'],
      mobile: json['mobile'],
      lastname: json['lastname'], firstname: json['firstname'], country_id: json['country_id'], ward_name: json['ward_name'], country_name: json['country_name'], city_name: json['city_name'],
      ward_id: json['ward_id'], street_id: json['street_id'], email: json['email'], sale_price: json['sale_price'],
      category_id: json['category_id'], SKU: json['SKU'], buying_price: json['buying_price'], regular_price: json['regular_price'],
      short_description: json['short_description'], slug: json['slug'], name: json['name'], customer_id: json['customer_id'], status: json['status'],
      delivery_company: json['delivery_company'], total: json['total'], subtotal: json['subtotal'], discount: json['discount'], tax: json['tax'],
      delivery_charge: json['delivery_charge'], city_id: json['city_id'], stock_status: json['stock_status'], add_type: json['add_type'], address_id: json['address_id'],
      orderitem_id: json['orderitem_id'], product_description: json['product_description'],
      product_quantity: json['product_quantity'], state_name: json['state_name'], transaction_id: json['transaction_id'], transaction_mode: json['transaction_mode'],
    );
  }
}
