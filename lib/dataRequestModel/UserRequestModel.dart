import 'dart:io';

import 'package:dio/dio.dart';

class UserRequestModel {
  String name;
  String email;
  String password;
  String utpye;
  File? newimage;

  UserRequestModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.utpye,
      required this.newimage});

  FormData toFormData()  {
    var map = {
      'name' : name,
      'email' : email,
      'password' : password,
      'utype' : utpye,
      'newimage' : [MultipartFile.fromFileSync(newimage!.path,filename: newimage?.path.split('/').last)],
    };
    return FormData.fromMap(map);
  }
}
