import 'Street.dart';

class StreetByWardIdResponse {
  final List<Street> data;
  final int status;
  final String message;

  StreetByWardIdResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory StreetByWardIdResponse.fromJson(Map<String, dynamic> json) {
    return StreetByWardIdResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((street) => Street.fromJson(street))
          .toList() ??
          [],
      status: json['status'],
      message: json['message'], // Corrected field name
    );
  }
}


