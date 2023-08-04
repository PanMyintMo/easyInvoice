class DeliveryCompanyResponse {
  List<CompanyData> companyData;
  int status;
  String message;

  DeliveryCompanyResponse({
    required this.companyData,
    required this.status,
    required this.message,
  });

  factory DeliveryCompanyResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryCompanyResponse(
      companyData: List<CompanyData>.from(
          json["companydata"].map((x) => CompanyData.fromJson(x))),
      status: json["status"],
      message: json["message"],
    );
  }
}

class CompanyData {
  int id;
  double? kg;
  String? description;
  String state;
  double basicCost;
  String waitingTime;
  int companyId;
  DateTime createdAt;
  DateTime updatedAt;
  int cityId;
  CompanyType companyType;

  CompanyData({
    required this.id,
    this.kg,
    this.description,
    required this.state,
    required this.basicCost,
    required this.waitingTime,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.cityId,
    required this.companyType,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      id: json["id"],
      kg: json["kg"]?.toDouble(),
      description: json["description"],
      state: json["state"],
      basicCost: json["basic_cost"].toDouble(),
      waitingTime: json["waiting_time"],
      companyId: json["company_id"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      cityId: int.parse(json["city_id"]),
      companyType: CompanyType.fromJson(json["company_type"]),
    );
  }
}

class CompanyType {
  int id;
  String name;
  String url;

  CompanyType({
    required this.id,
    required this.name,
    required this.url,
  });

  factory CompanyType.fromJson(Map<String, dynamic> json) {
    return CompanyType(
      id: json["id"],
      name: json["name"],
      url: json["url"],
    );
  }
}
