class AddCityResponse {
  final int status;
  final String message;
  final AddCityResponseData data;
  AddCityResponse(
      {required this.status, required this.message, required this.data});

  factory AddCityResponse.fromJson(Map<String, dynamic> json) =>
      AddCityResponse(status: json['status'], message: json['message'],
          data: AddCityResponseData.fromJson(json['data']));
}

class AddCityResponseData {
  final String country_id;
  final String name;
  final String updated_at;
  final String created_at;
  final int id;

  AddCityResponseData({required this.country_id,
    required this.name, required this.updated_at, required this.created_at, required this.id});

  factory AddCityResponseData.fromJson(Map<String, dynamic> json){
    return AddCityResponseData(
        country_id: json['country_id'],
        name: json['name'],
        updated_at: json['updated_at'],
        created_at: json['created_at'],
        id: json['id']
    );
  }


}