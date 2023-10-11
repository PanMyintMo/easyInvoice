class UserResponse {
  String name;
  String email;
  String utype;
  String updated_at;
  String created_at;
  int id;
  String profile_photo_url;
  int status;
  String message;

  UserResponse(
      {required this.name,
      required this.email,
      required this.utype,
      required this.updated_at,
      required this.created_at,
      required this.id,
      required this.profile_photo_url,
      required this.status,
      required this.message});

  factory UserResponse.fromJson(Map<String, dynamic> data) {
    final dataJson = data['data'] as Map<String, dynamic>;
    return UserResponse(
        name: dataJson['name'],
        email: dataJson['email'],
        utype: dataJson['utype'],
        updated_at: dataJson['updated_at'],
        created_at: dataJson['created_at'],
        id: dataJson['id'],
        profile_photo_url: dataJson['profile_photo_url'],
        status: data['status'],
        message: data['message']);
  }
}
