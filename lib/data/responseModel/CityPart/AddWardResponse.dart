class AddWardResponse{
  final AddWardData data;
  final int status;
  final String message;

  AddWardResponse({required this.data, required this.status, required this.message});

  factory AddWardResponse.fromJson(Map<String , dynamic> json){
    return AddWardResponse(
        data: AddWardData.fromJson(json['data']), // Parse data using AddWardData.fromJson
        status: json['status'], message: json['message']);
  }

}
class AddWardData {
  final String state_id;
  final String ward_name;
  final String updated_at;
  final String created_at;
  final int id;

  AddWardData(
      {required this.state_id,
      required this.ward_name,
      required this.updated_at,
      required this.created_at,
      required this.id});


  factory AddWardData.fromJson(Map<String,dynamic> json){
    return AddWardData(state_id: json['state_id'],
        ward_name: json['ward_name'], updated_at: json['updated_at'],
        created_at: json['created_at'], id: json['id']);
  }
}