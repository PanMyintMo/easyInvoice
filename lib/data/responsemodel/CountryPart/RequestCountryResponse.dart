class RequestCountryResponse {
  final int status;
  final String message;
  final RequestCountryData data;

  RequestCountryResponse(
      {required this.status, required this.message, required this.data});

  factory RequestCountryResponse.fromJson(Map<String, dynamic> json) =>
      RequestCountryResponse(
          status: json['status'],
          message: json['message'],
          data: RequestCountryData.fromJson(json['data']));
}

class RequestCountryData {
  final String name;
  final String updated_at;
  final String created_at;
  final int id;

  RequestCountryData(
      {required this.name,
      required this.updated_at,
      required this.created_at,
      required this.id});

  factory RequestCountryData.fromJson(Map<String, dynamic> json) {
    return RequestCountryData(
      name: json['name'],
      id: json['id'],
      updated_at: json['updated_at'],
      created_at: json['created_at'],
    );
  }
}
