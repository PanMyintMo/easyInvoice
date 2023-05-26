import 'package:json_annotation/json_annotation.dart';

part 'LoginResponse.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: '_id')
  String id;
  String username;
  String email;
  String bio;
  String dob;
  String address;
  String gender;
  List<String> profilePicture;
  bool login;
  bool verified;
  bool isAdmin;
  String token;

  LoginResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.bio,
    required this.dob,
    required this.address,
    required this.gender,
    required this.profilePicture,
    required this.login,
    required this.verified,
    required this.isAdmin,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}



