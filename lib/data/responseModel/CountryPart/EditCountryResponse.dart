class EditCountryResponse{
  final int status;
  final String message;
  final EditCountryResponseData data;

  EditCountryResponse({required this.status,required this.message,required this.data});

  factory EditCountryResponse.fromJson(Map<String, dynamic> json) =>
      EditCountryResponse(status: json['status'], message: json['message'],
          data: EditCountryResponseData.fromJson(json['data']));

}

class EditCountryResponseData {
  final int id;
  final String name;
  final String created_at;
  final String updated_at;

  EditCountryResponseData({required this.id,required this.name,
  required this.created_at, required this.updated_at});


  factory EditCountryResponseData.fromJson(Map<String, dynamic> json){
    return EditCountryResponseData(
        id: json['id'],
        name: json['name'],
        updated_at: json['updated_at'],
        created_at: json['created_at'],
    );
  }
}