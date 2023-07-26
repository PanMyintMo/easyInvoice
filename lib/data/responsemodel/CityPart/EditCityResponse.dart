class EditCityResponse{
  final int status;
  final String message;
  final EditCityResponseData data;

  EditCityResponse({required this.status,required this.message,required this.data});

  factory EditCityResponse.fromJson(Map<String, dynamic> json) =>
      EditCityResponse(status: json['status'], message: json['message'],
          data: EditCityResponseData.fromJson(json['data']));

}

class EditCityResponseData {
  final int id;
  final String name;
  final String country_id;
  final String created_at;
  final String updated_at;

  EditCityResponseData( {required this.id,required this.name,required this.country_id,
    required this.created_at, required this.updated_at});


  factory EditCityResponseData.fromJson(Map<String, dynamic> json){
    return EditCityResponseData(
      id: json['id'],
      country_id : json['country_id'],
      name: json['name'],
      updated_at: json['updated_at'],
      created_at: json['created_at'],
    );
  }
}