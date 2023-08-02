import 'dart:io';
import 'package:dio/dio.dart';
class EditCompanyProfileRequestModel {
  final String mobile;
  final String line1;
  final String line2;
  final String city;
  final String country;
  final String zipcode;
  final String company_name;
  final File newimage;

  EditCompanyProfileRequestModel({
    required this.mobile,
    required this.line1,
    required this.line2,
    required this.city,
    required this.country,
    required this.zipcode,
    required this.company_name,
    required this.newimage,
  });

  FormData toFormData()  {
    var map = {
      'mobile': mobile,
      'line1': line1,
      'line2': line2,
      'city': city,
      'country': country,
      'zipcode': zipcode,
      'company_name': company_name,
      'newimage' : [MultipartFile.fromFileSync(newimage.path,filename: newimage.path.split('/').last)]
    };
    return FormData.fromMap(map);
  }
}
