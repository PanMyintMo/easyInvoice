class TownshipByCityIdResponse {
  final List<TownshipByCityIdData> data;
  final int status;
  final String message;

  TownshipByCityIdResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory TownshipByCityIdResponse.fromJson(Map<String, dynamic> json) {
    return TownshipByCityIdResponse(
      data: List<TownshipByCityIdData>.from(
        json['data'].map((cityJson) => TownshipByCityIdData.fromJson(cityJson)),
      ),
      status: json['status'],
      message: json['message'],
    );
  }
}

class TownshipByCityIdData {
  final int id;
  final int city_id;
  final String name;
  final String created_at;
  final String updated_at;

  TownshipByCityIdData(
      {required this.id,
        required this.city_id,
        required this.name,
        required this.updated_at,
        required this.created_at});

  factory TownshipByCityIdData.fromJson(Map<String, dynamic> data) {
    return TownshipByCityIdData(
        id: data['id'],
        city_id: data['city_id'],
        name: data['name'],
        created_at: data['created_at'],
        updated_at: data['updated_at']);
  }
}
