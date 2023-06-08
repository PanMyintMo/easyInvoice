import 'package:dio/dio.dart';
import 'SharedPreferenceHelper.dart';

class MyRequestInterceptor extends Interceptor {
  final String tokenKey;
  final SessionManager _preferences;

  MyRequestInterceptor(this.tokenKey) : _preferences = SessionManager();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    final token =await  _preferences.getAuthToken();
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}
