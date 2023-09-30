class WardByTownshipResponse {
  final List<WardByTownshipData> data;
  final int status;
  final String message;

  WardByTownshipResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory WardByTownshipResponse.fromJson(Map<String, dynamic> json) {
    return WardByTownshipResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((ward) => WardByTownshipData.fromJson(ward))
          .toList() ??
          [],
      status: json['status'],
      message: json['message'], // Corrected field name
    );
  }
}

class WardByTownshipData {

  final int id;
  final int township_id;
  final String ward_name;
  final String created_at;
  final String updated_at;
  WardByTownshipData({required this.id,required this.township_id,
  required this.ward_name,required this.created_at,required this.updated_at});


  factory WardByTownshipData.fromJson(Map<String,dynamic> json){
    return WardByTownshipData(
        id: json['id'],
        township_id: json['township_id'],
        ward_name: json['ward_name'],
        created_at: json['created_at'],
        updated_at: json['updated_at']

    );
  }

}


