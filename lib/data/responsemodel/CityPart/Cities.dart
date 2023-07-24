class CityResponse {

  final CityData data;

  CityResponse({ required this.data});

  factory CityResponse.fromJson(Map<String, dynamic> json) {
    return CityResponse(
      data: CityData.fromJson(json['data']),
    );
  }
}

class CityData {
  final int currentPage;
  final List<City> cities;
  final String firstPageUrl;
  final int lastPage;
  final String lastPageUrl;
  final List<CityLink> links;
  final String? nextPageUrl;

  CityData({
    required this.currentPage,
    required this.cities,
    required this.firstPageUrl,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    var citiesList = json['data'] as List;
    List<City> cities = citiesList.map((cityJson) => City.fromJson(cityJson)).toList();

    var linksList = json['links'] as List;
    List<CityLink> links = linksList.map((linkJson) => CityLink.fromJson(linkJson)).toList();

    return CityData(
      currentPage: json['current_page'],
      cities: cities,
      firstPageUrl: json['first_page_url'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: links,
      nextPageUrl: json['next_page_url'],
    );
  }
}

class City {
  final int id;
  final int countryId;
  final String name;
  final String createdAt;
  final String? updatedAt;

  City({
    required this.id,
    required this.countryId,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      countryId: json['country_id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class CityLink {
  final String? url;
  final String label;
  final bool active;

  CityLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory CityLink.fromJson(Map<String, dynamic> json) {
    return CityLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}
