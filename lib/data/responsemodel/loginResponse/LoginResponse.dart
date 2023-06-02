
class LoginResponse {
  String status;
  String message;
  String token;
  LoginResponse(
    this.status, this.message, this.token
  );

factory LoginResponse.fromJson(Map<String,dynamic> data){
  return LoginResponse(data['status'] as String,
      data['message'] as String,
      data['token'] as String);
}
}



