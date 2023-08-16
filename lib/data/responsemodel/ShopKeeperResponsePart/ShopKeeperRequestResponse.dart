class ShopKeeperRequestResponse{
  final List<ShopRequestData> data;
  final int status;
  final String message;

  ShopKeeperRequestResponse({required this.data,required this.status,required this.message});

  factory ShopKeeperRequestResponse.fromJson(Map<String,dynamic> json){
    return ShopKeeperRequestResponse(
        data:  List<ShopRequestData>.from(json['data'].map((shopData) => ShopRequestData.fromJson(shopData))),
        status: json['status'], message: json['message']

    );
  }

}

class ShopRequestData {
  final int id;
  final int quantity;
  final int product_id;
  final String status;
  final String product_name;
  ShopRequestData({required this.id,required this.quantity,required this.product_id,
  required this.status,required this.product_name});

  factory ShopRequestData.fromJson(Map<String,dynamic> json)  {

    return ShopRequestData(id: json['id'], quantity: json['quantity'],
        product_id: json['product_id'], status: json['status'], product_name: json['product_name']);

  }

}