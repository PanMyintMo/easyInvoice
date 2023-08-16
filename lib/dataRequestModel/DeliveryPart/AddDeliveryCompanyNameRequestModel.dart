import 'dart:io';
import 'package:dio/dio.dart';
class AddDeliveryRequestModel{

  final String name;
  final File image;

  AddDeliveryRequestModel({required this.name,required this.image});

  FormData toFormData(){
    var map = {
      'name' : name,
      'image' : [MultipartFile.fromFileSync(image.path,filename: image.path.split('/').last)]
    };
    return FormData.fromMap(map);
  }
}

