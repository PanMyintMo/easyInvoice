import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../dataModel/LoginRequestModel.dart';
import '../../dataModel/RegisterRequestModel.dart';
import '../model/loginResponse/LoginResponse.dart';
import '../model/registerResponse/RegisterResponse.dart';

part 'apiService.g.dart';
@RestApi(baseUrl: 'https://www.myanfobase.com/api/')
abstract class ApiService {

 factory ApiService(Dio dio) => _ApiService(dio);
  //for register
  @POST('users')
  Future<RegisterResponse> signup(@Body() RegisterRequestModel registerRequestModel);
  //for login
  @POST('users/login')
  Future<LoginResponse> signin(@Body() LoginRequestModel loginRequestModel);
}

