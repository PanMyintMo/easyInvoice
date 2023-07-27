class EditTownshipResponse{
  final int status;
  final String message;
  final EditTownshipResponseData data;

  EditTownshipResponse({required this.status,required this.message,required this.data});

  factory EditTownshipResponse.fromJson(Map<String, dynamic> json) =>
      EditTownshipResponse(status: json['status'], message: json['message'],
          data: EditTownshipResponseData.fromJson(json['data']));

}

class EditTownshipResponseData {
  final int id;
  final String name;
  final String city_id;
  final String created_at;
  final String updated_at;

  EditTownshipResponseData( {required this.id,required this.name,required this.city_id,
    required this.created_at, required this.updated_at});


  factory EditTownshipResponseData.fromJson(Map<String, dynamic> json){
    return EditTownshipResponseData(
      id: json['id'],
      city_id : json['city_id'],
      name: json['name'],
      updated_at: json['updated_at'],
      created_at: json['created_at'],
    );
  }
}