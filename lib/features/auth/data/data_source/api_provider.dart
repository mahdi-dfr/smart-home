import 'package:dio/dio.dart';
import 'package:turkeysh_smart_home/features/auth/data/data_source/aip_interseptor.dart';
import '../../../../../core/constants/url_constant.dart';

class AuthApiProvider {
  final Dio _dio = Dio();

  /// register user
  Future<dynamic> registerUser(FormData registerBody) async {
    _dio.interceptors.add(AuthApiInterceptor());
    var response = await _dio.post(
      UrlConstant.baseUrl + UrlConstant.register,
      data: registerBody,
      options: Options(responseType: ResponseType.json, method: 'POST'),
    );
    return response;
  }

  /// login user
  Future<dynamic> loginUser(String username, String password) async {
    _dio.interceptors.add(AuthApiInterceptor());
    var response = await _dio.post(UrlConstant.baseUrl + UrlConstant.login,
        options: Options(responseType: ResponseType.json, method: 'POST'),
        data: {'username': username, 'password': password});
    return response;
  }

  /// refresh user token if expired
// Future<dynamic> refreshToken(Map<String, dynamic> refreshData) async {
//   _dio.interceptors.add(AuthApiInterceptor());
//   var response = await _dio.post(UrlConstant.baseUrl + UrlConstant.refresh,
//       options: Options(responseType: ResponseType.json, method: 'POST'), data: refreshData);
//   print(response);
//
//   return response;
// }
}
