import 'package:json_annotation/json_annotation.dart';
part 'RegisterResponse.g.dart';

@JsonSerializable()
class RegisterResponse {
  String status;
  String message;
  RegisterResponse(this.status, this.message);

  factory RegisterResponse.fromJson(Map<String,dynamic>json) => _$RegisterResponseFromJson(json);
  Map<String,dynamic> toJson() => _$RegisterResponseToJson(this);

}
