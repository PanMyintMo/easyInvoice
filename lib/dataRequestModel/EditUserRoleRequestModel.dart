import 'dart:io';

import 'package:dio/dio.dart';

class EditUserRoleRequestModel {
  String name;
  String email;
  String password;
  String utype;
  File? newimage;

  EditUserRoleRequestModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.utype,
      required this.newimage});

  FormData toFormData() {
    var map = {
      'name': name,
      'email': email,
      'password': password,
      'utype': utype,
      // 'newimage' : [MultipartFile.fromFileSync(newimage!.path,filename: newimage?.path.split('/').last)],

      'newimage': [
        newimage != null
            ? MultipartFile.fromFileSync(newimage!.path,
                filename: newimage!.path.split('/').last)
            : null
      ],
    };
    return FormData.fromMap(map);
  }
}
