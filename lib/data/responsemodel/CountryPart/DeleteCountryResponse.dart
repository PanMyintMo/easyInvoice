class DeleteCountryResponse{
  final int status;
  final String message;

  DeleteCountryResponse({required this.status,required this.message});

  factory DeleteCountryResponse.fromJson(Map<String, dynamic> json){
    return DeleteCountryResponse(status: json['status'], message: json['message']);
  }
}