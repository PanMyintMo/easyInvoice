class RegisterResponse {
  String name;
  String email;
  String updated_at;
  String created_at;
  int id;
  String profile_photo_url;
  int status;
  String message;
  String token;

  RegisterResponse({
    required this.name,
    required this.email,
    required this.updated_at,
    required this.created_at,
    required this.id,
    required this.profile_photo_url,
    required this.status,
    required this.message,
    required this.token,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> data) {
    final dataJson = data['data'] as Map<String, dynamic>;
    return RegisterResponse(
        name: dataJson['name'] as String,
        email: dataJson['email'] as String,
        updated_at: dataJson['updated_at'] as String,
        created_at: dataJson['created_at'] as String,
        id: dataJson['id'] as int,
        profile_photo_url: dataJson['profile_photo_url'],
        status: data['status'],
        message: data['message'],
        token: data['token']);
  }
}
