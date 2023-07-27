class CityByCountryIdResponse {
  final List<CityByCountryIdData> data;
  final int status;
  final String message;

  CityByCountryIdResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory CityByCountryIdResponse.fromJson(Map<String, dynamic> json) {
    return CityByCountryIdResponse(
      data: List<CityByCountryIdData>.from(
        json['data'].map((cityJson) => CityByCountryIdData.fromJson(cityJson)),
      ),
      status: json['status'],
      message: json['message'],
    );
  }
}

class CityByCountryIdData {
  final int id;
  final int country_id;
  final String name;
  final String created_at;
  final String updated_at;

  CityByCountryIdData(
      {required this.id,
      required this.country_id,
      required this.name,
      required this.updated_at,
      required this.created_at});

  factory CityByCountryIdData.fromJson(Map<String, dynamic> data) {
    return CityByCountryIdData(
        id: data['id'],
        country_id: data['country_id'],
        name: data['name'],
        created_at: data['created_at'],
        updated_at: data['updated_at']);
  }
}
