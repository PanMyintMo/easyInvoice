import '../MainPagePart/MainPageResponse.dart';

class OrderDetailResponse {
  final OrderDatas data;
  final int status;
  final String message;

  OrderDetailResponse(
      {required this.data, required this.status, required this.message});

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponse(
      data: OrderDatas.fromJson(json['data']),
      status: json['status'],
      message: json['message'],
    );
  }
}
