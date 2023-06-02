import 'package:dio/dio.dart';
import '../../dataModel/RegisterRequestModel.dart';
import '../responsemodel/registerResponse/RegisterResponse.dart';

class ApiService {
  final Dio _dio = Dio();
  //final String token;

  ApiService() {
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.validateStatus =
        (status) => true; // Allow handling of all status codes
    _dio.options.followRedirects = true; // Disable automatic redirect following
   // _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<RegisterResponse> signUp(
      RegisterRequestModel registerRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/register',
        data: registerRequestModel.toJson(),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final RegisterResponse data = RegisterResponse.fromJson(response.data);
        return data;
      } else if (response.statusCode == 302) {
        if (response.data is String) {
          final String responseData = response.data;
          // Handle the response data as a string
          final registerResponse = RegisterResponse(
            status: response.statusCode ?? 0,
            message: responseData,
            token: '',
          );
          return registerResponse;
        } else {
          // Handle other cases when the response data is not a string
          throw DioError(
              requestOptions: RequestOptions(path: '/api/register'),
              response: response);
        }
      } else {
        print("My response status code is ${response.statusCode}");
        throw DioError(
            requestOptions: RequestOptions(path: '/api/register'),
            response: response);
      }
    } catch (error) {
      print('Signup error: $error');
      throw DioError(
          requestOptions: RequestOptions(path: '/api/register'), error: error);
    }
  }
}
