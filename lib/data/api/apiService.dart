import 'package:dio/dio.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import '../../dataModel/RegisterRequestModel.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/RegisterResponse.dart';


class ApiService {
  final Dio _dio = Dio();

  final String token;

  ApiService(this.token) {
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.validateStatus =
        (status) => true; // Allow handling of all status codes
    _dio.options.followRedirects = true; // Disable automatic redirect following
    _dio.options.headers;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ));
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
      }
       else {
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


  Future<LoginResponse> signIn(LoginRequestModel loginRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/login',
        data: loginRequestModel.toJson(),
      );

      print('Response Login Status code ${response.statusCode}');
      print('Response login data ${response.data}');

      if (response.statusCode == 200) {
        final LoginResponse data = LoginResponse.fromJson(response.data);
        return data;
      } else {
        print("My response status code is ${response.statusCode}");
        throw DioError(
          requestOptions: RequestOptions(path: '/api/login'),
          response: response,
        );
      }
    } catch (error) {
      print('Sign In error: $error');
      throw DioError(
        requestOptions: RequestOptions(path: '/api/login'),
        error: error,
      );
    }
  }
}
