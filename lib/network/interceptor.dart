import 'package:dio/dio.dart';
import 'SharedPreferenceHelper.dart';

class MyRequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final sessionManager = SessionManager();
    final token = sessionManager.getAuthToken();
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}
