class ChangeOrderStatusRequestModel{
  final String order_id;
  final String status;

  ChangeOrderStatusRequestModel({required this.order_id,required this.status});

  Map<String, dynamic> toJson() {
    return {
      'order_id': order_id,
      'status': status,
    };
  }
}