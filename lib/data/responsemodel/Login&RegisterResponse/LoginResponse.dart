class LoginResponse {
  int? id;
  String name;
  String email;
  DateTime? emailVerifiedAt;
  String? image;
  String utype;
  String? url;
  int status;
  String message;
  String token;

  LoginResponse({
    this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.image,
    required this.utype,
    required this.url,
    required this.status,
    required this.message,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> data) {
    final dataJson = data['data'] as Map<String, dynamic>;
    return LoginResponse(
      id: dataJson['id'] as int?,
      name: dataJson['name'] as String,
      email: dataJson['email'] as String,
      emailVerifiedAt: dataJson['email_verified_at'] != null
          ? DateTime.parse(dataJson['email_verified_at'] as String)
          : null,
      image: dataJson['image'] as String?,
      utype: dataJson['utype'] as String,
      url: dataJson['url'] as String?,
      status: data['status'] as int,
      message: data['message'] as String,
      token: data['token'] as String,
    );
  }
}
