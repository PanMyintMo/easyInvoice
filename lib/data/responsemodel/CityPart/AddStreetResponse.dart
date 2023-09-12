class AddStreetResponse{
  final AddStreetData data;
  final int status;
  final String message;

  AddStreetResponse({required this.data, required this.status, required this.message});

  factory AddStreetResponse.fromJson(Map<String , dynamic> json){
    return AddStreetResponse(
        data: AddStreetData.fromJson(json['data']), // Parse data using AddWardData.fromJson
        status: json['status'], message: json['message']);
  }

}
class AddStreetData {
  final String ward_id;
  final String street_name;
  final String updated_at;
  final String created_at;
  final int id;

  AddStreetData(
      {required this.ward_id,
        required this.street_name,
        required this.updated_at,
        required this.created_at,
        required this.id});


  factory AddStreetData.fromJson(Map<String,dynamic> json){
    return AddStreetData(ward_id: json['ward_id'],
        street_name: json['street_name'], updated_at: json['updated_at'],
        created_at: json['created_at'], id: json['id']);
  }
}