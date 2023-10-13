import '../TownshipsPart/AllTownshipResponse.dart';

class Ward {
  final int id;
  final int township_id;
  final String ward_name;
  final String? created_at;
  final String? updated_at;
  final Township township;

  Ward({
    required this.id,
    required this.township_id,
    required this.ward_name,
    required this.created_at,
    required this.updated_at,
    required this.township,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['id'],
      township_id: json['township_id'],
      ward_name: json['ward_name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      township: Township.fromJson(json['township']),
    );
  }
}

/*class Townships {
  final int id;
  final int city_id;
  final String name;
  final String created_at;
  final String updated_at;
  final Cities cities;

  Townships({
    required this.id,
    required this.city_id,
    required this.name,
    required this.created_at,
    required this.updated_at,
    required this.cities,
  });

  factory Townships.fromJson(Map<String, dynamic> json) {
    return Townships(
      id: json['id'],
      city_id: json['city_id'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      cities: Cities.fromJson(json['cities']),
    );
  }
}

class Cities {
  final int id;
  final int country_id;
  final String name;
  final String created_at;
  final String updated_at;

  Cities({
    required this.id,
    required this.country_id,
    required this.name,
    required this.created_at,
    required this.updated_at,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['id'],
      country_id: json['country_id'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}*/
