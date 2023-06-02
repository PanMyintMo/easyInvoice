import 'package:dio/dio.dart';
import 'SharedPreferenceHelper.dart';

class MyRequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //Add the request body to the log
    if (options.data != null) {
      print('Request body :${options.data}');
    }
    handler.next(options);
    final sessionManager = SessionManager();
    final token = sessionManager.getAuthToken();
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.data != null){
      print('Response body : ${response.data}');
    }
    handler.next(response);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {

    //Log the error
    print('Dio error :${err.toString()}');
    handler.next(err);

  }

}
