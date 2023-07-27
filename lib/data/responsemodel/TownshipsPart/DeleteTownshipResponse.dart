class DeleteTownshipResponse{
  final int status;
  final String message;

  DeleteTownshipResponse({required this.status,required this.message});

  factory DeleteTownshipResponse.fromJson(Map<String, dynamic> json){
    return DeleteTownshipResponse(status: json['status'], message: json['message']);
  }
}