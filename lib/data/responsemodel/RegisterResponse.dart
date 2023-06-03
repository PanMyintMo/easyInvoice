class RegisterResponse {
  int status;
  String message;
  String token;

  RegisterResponse({
    required this.status,
    required this.message,
    required this.token,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> data) {
    return RegisterResponse(
        status: data['status'], message: data['message'], token: data['token']);
  }
}
