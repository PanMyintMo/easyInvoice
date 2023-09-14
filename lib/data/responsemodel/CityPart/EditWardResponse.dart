import 'AddWardResponse.dart';

class EditWardResponse{
  final AddWardData data;
  final int status;
  final String message;

  EditWardResponse({required this.data, required this.status, required this.message});

  factory EditWardResponse.fromJson(Map<String , dynamic> json){
    return EditWardResponse(
        data: AddWardData.fromJson(json['data']), // Parse data using AddWardData.fromJson
        status: json['status'], message: json['message']);
  }

}
