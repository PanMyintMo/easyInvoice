

import '../common/WardResponse.dart';
class WardByTownshipResponse {
  final List<Ward> data;
  final String status;
  final String message;

  WardByTownshipResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory WardByTownshipResponse.fromJson(Map<String, dynamic> json) {
    return WardByTownshipResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((ward) => Ward.fromJson(ward))
          .toList() ??
          [],
      status: json['status'],
      message: json['message'], // Corrected field name
    );
  }
}


