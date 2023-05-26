import 'package:dio/dio.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/model/loginResponse/LoginResponse.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import 'package:easy_invoice/dataModel/RegisterRequestModel.dart';
import '../../network/interceptor.dart';
import '../model/registerResponse/RegisterResponse.dart';

class UserRepository {
 late final ApiService _apiService;

  UserRepository() : _apiService = _createApiService();

  static ApiService _createApiService() {
    // Create a Dio instance
    Dio dio = Dio();

    // Set the global content-type
    dio.options.headers['Content-Type'] = 'application/json';

    //Add the interceptor
    dio.interceptors.add(MyRequestInterceptor());

    // Use the Dio instance when creating the ApiService
    return ApiService(dio);
  }


  Future<RegisterResponse> singnup(RegisterRequestModel registerRequestModel) =>
      _apiService.signup(registerRequestModel);

  Future<LoginResponse> signin(LoginRequestModel loginRequestModel) =>
      _apiService.signin(loginRequestModel);

}
