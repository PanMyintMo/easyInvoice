class DeliCompanyInfoResponse {
  final String company_id;
  final String township_id;
  final String basic_cost;
  final String waiting_time;
  final String updated_at;
  final String created_at;
  final int id;

  DeliCompanyInfoResponse({
    required this.company_id,
    required this.township_id,
    required this.basic_cost,
    required this.waiting_time,
    required this.updated_at,
    required this.created_at,
    required this.id,
  });

  factory DeliCompanyInfoResponse.fromJson(Map<String, dynamic> json) {
    return DeliCompanyInfoResponse(
      company_id: json['data']['company_id'],
      township_id: json['data']['township_id'],
      basic_cost: json['data']['basic_cost'],
      waiting_time: json['data']['waiting_time'],
      updated_at: json['data']['updated_at'],
      created_at: json['data']['created_at'],
      id: json['data']['id'],
    );
  }
}
