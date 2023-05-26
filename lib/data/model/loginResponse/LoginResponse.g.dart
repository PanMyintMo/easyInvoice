// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      id: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      dob: json['dob'] as String,
      address: json['address'] as String,
      gender: json['gender'] as String,
      profilePicture: (json['profilePicture'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      login: json['login'] as bool,
      verified: json['verified'] as bool,
      isAdmin: json['isAdmin'] as bool,
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'bio': instance.bio,
      'dob': instance.dob,
      'address': instance.address,
      'gender': instance.gender,
      'profilePicture': instance.profilePicture,
      'login': instance.login,
      'verified': instance.verified,
      'isAdmin': instance.isAdmin,
      'token': instance.token,
    };
