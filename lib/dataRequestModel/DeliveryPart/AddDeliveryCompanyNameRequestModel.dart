import 'dart:io';

class AddDeliveryRequestModel{

  final String name;
  final File image;

  AddDeliveryRequestModel({required this.name,required this.image});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image
    };
  }
}