class EditCompanyProfileResponse {
  final int status;
  final String message;
  final EditCompanyProfileData data;

  EditCompanyProfileResponse(
      {required this.status, required this.message, required this.data});

  factory EditCompanyProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditCompanyProfileResponse(
        status: json['status'],
        message: json['message'],
        data: EditCompanyProfileData.fromJson(json['data']));
  }
}

class EditCompanyProfileData {
  final int id;
  final int user_id;
  final String mobile;
  final String line1;
  final String line2;
  final String city;
  final String country;
  final String zipcode;
  final String company_name;
  final String created_at;
  final String url;

  EditCompanyProfileData({
    required this.id,
    required this.user_id,
    required this.mobile,
    required this.line1,
    required this.line2,
    required this.city,required this.country,
    required this.zipcode,required this.company_name,
    required this.created_at,
    required this.url
});
  

  factory EditCompanyProfileData.fromJson(Map<String, dynamic> json) {
    return EditCompanyProfileData(
      id: json['id'],
      user_id: json['user_id'],
      mobile: json['mobile'],
      line1: json['line1'],
      line2: json['line2'],
      city: json['city'],
      country: json['country'],
      company_name: json['company_name'],
      created_at: json['created_at'],
      url: json['url'],
      zipcode: json['zipcode'],
    );
  }
}
