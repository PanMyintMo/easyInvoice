class SizeDeleteResponse{
  int status;
  String message;
  SizeDeleteResponse({required this.status,required this.message});

  factory SizeDeleteResponse.fromJson(Map<String, dynamic> json){
    return SizeDeleteResponse(status: json['status'], message: json['message']);
  }
}