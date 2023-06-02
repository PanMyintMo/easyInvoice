import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/registerResponse/RegisterResponse.dart';
import 'package:easy_invoice/dataModel/RegisterRequestModel.dart';

class UserRepository {
  final ApiService _apiService= ApiService();

  Future<RegisterResponse> signUp(RegisterRequestModel registerRequestModel) async {
    try {
      final response = await _apiService.signUp(registerRequestModel);
      return response;
    } catch (error) {
      throw error;
    }
  }
}

