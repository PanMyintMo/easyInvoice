class AddTownshipResponse {
  final int status;
  final String message;
  final AddTownshipResponseData data;
  AddTownshipResponse(
      {required this.status, required this.message, required this.data});

  factory AddTownshipResponse.fromJson(Map<String, dynamic> json) =>
      AddTownshipResponse(status: json['status'], message: json['message'],
          data: AddTownshipResponseData.fromJson(json['data']));
}

class AddTownshipResponseData {
  final String city_id;
  final String name;
  final String updated_at;
  final String created_at;
  final int id;

  AddTownshipResponseData({required this.city_id,
    required this.name, required this.updated_at, required this.created_at, required this.id});

  factory AddTownshipResponseData.fromJson(Map<String, dynamic> json){
    return AddTownshipResponseData(
        city_id: json['city_id'],
        name: json['name'],
        updated_at: json['updated_at'],
        created_at: json['created_at'],
        id: json['id']
    );
  }
}