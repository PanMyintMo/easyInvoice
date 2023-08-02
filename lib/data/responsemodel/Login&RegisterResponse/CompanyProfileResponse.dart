class CompanyProfileResponse {
  final int status;
  final String message;
  final CompanyProfileData data;

  CompanyProfileResponse(
      {required this.status, required this.message, required this.data});

  factory CompanyProfileResponse.fromJson(Map<String, dynamic> json) {
    return CompanyProfileResponse(
        status: json['status'],
        message: json['message'],
        data: CompanyProfileData.fromJson(json['data']));
  }
}

class CompanyProfileData {
  final int user_id;

  final String? url;

  CompanyProfileData(
      {required this.user_id,

      required this.url});

  factory CompanyProfileData.fromJson(Map<String, dynamic> json) {
    return CompanyProfileData(
        user_id: json['user_id'],
        url: json['url']);
  }
}
