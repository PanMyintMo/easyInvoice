import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/RegisterResponse.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import 'package:easy_invoice/dataModel/RegisterRequestModel.dart';

import '../responsemodel/LoginResponse.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository({required String token}) : _apiService = ApiService(token);

  //For Register
  Future<RegisterResponse> signUp(RegisterRequestModel registerRequestModel) async {
    try {
      final response = await _apiService.signUp(registerRequestModel);

      return response;
    } catch (error) {
      throw error;
    }
  }

  //For Login
  Future<LoginResponse> signIn(LoginRequestModel loginRequestModel) async {
    try {
      final response = await _apiService.signIn(loginRequestModel);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
