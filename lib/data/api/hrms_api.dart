import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/endpoints.dart';

class HrmsApi {
  final Dio _dio = Dio();

  HrmsApi() {
    _dio.options.connectTimeout = 7000;
    _dio.options.receiveTimeout = 600000;
    _dio.options.sendTimeout = 600000;
    _dio.options.baseUrl = Endpoints.apiBaseUrl;
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Check if the request is for the login or OTP endpoint
        if (!options.path.contains('signin') && !options.path.contains('otp')) {
          String token = await getToken();
          print('AuthorizationToken====$token');
          if (token.isNotEmpty) {
            options.headers["x-access-token"] = token;
          }
        }
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioError error, handler) {
        return handler.next(error); // continue
      },
    ));
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_token") ?? ''; // Return empty string if token is null
  }



  Dio get sendRequest => _dio;
}
