class DeleteCityResponse{
  final int status;
  final String message;

  DeleteCityResponse({required this.status,required this.message});

  factory DeleteCityResponse.fromJson(Map<String, dynamic> json){
    return DeleteCityResponse(status: json['status'], message: json['message']);
  }
}