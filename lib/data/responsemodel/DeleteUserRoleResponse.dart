class DeleteUserRoleResponse{
  int status;
  String message;
  DeleteUserRoleResponse({required this.status,required this.message});

  factory DeleteUserRoleResponse.fromJson(Map<String, dynamic> json){
    return DeleteUserRoleResponse(status: json['status'], message: json['message']);
  }
}