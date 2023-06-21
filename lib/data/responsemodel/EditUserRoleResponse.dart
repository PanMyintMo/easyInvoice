class EditUserRoleResponse{
  int id;
  String name;
  String email;
  DateTime? email_verified_at;
  DateTime created_at;
  DateTime updated_at;
  String utype;
  String? image;
  String? url;
  String profile_photo_url;
  int status;
  String message;

  EditUserRoleResponse({required this.id,required this.name, required this.email,
  required this.email_verified_at,required this.created_at, required this.updated_at,
  required this.utype, required this.image, required this.url, required this.profile_photo_url,
  required this.status, required this.message});

factory EditUserRoleResponse.fromJson(Map<String,dynamic> json){
  final userData = json['data'] as Map<String,dynamic>;
  return EditUserRoleResponse(id: userData['id'], name: userData['name'],
      email: userData['email'],
      email_verified_at: userData['email_verified_at'] != null ? DateTime.parse(userData['email_verified_at']) : null ,
      created_at: userData['created_at'] ,
      updated_at: userData['updated_at'],
      utype: userData['utype'], image: userData['image'] != null ? userData['image'] : null,
      url: userData['url'] != null ? userData['url'] : null,
      profile_photo_url: userData['profile_photo_url'], status: json['status'], message: json['message']);
}
}
