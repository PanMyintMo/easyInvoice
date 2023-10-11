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
  int company_id;
  int basic_cost;
  String waiting_time;
  String township_id;
  String? description;
  CompanyType company_type;

  CompanyData(
      {required this.id,
      required this.basic_cost,
      required this.waiting_time,
      required this.township_id,
      required this.description,
      required this.company_id,
      required this.company_type});

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      id: json["id"],
      description: json["description"],
      basic_cost: json["basic_cost"],
      waiting_time: json["waiting_time"],
      township_id: json['township_id'],
      company_id: json['company_id'],
      company_type: CompanyType.fromJson(json['company_type']),
    );
  }
}

class CompanyType {
  final int id;
  final String name;
  final String url;

  CompanyType({required this.id, required this.name, required this.url});

  factory CompanyType.fromJson(Map<String, dynamic> json) {
    return CompanyType(
      id: json["id"],
      name: json["name"],
      url: json["url"],
    );
  }
}
