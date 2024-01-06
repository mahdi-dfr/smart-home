import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/routes.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';

import '../../../auth/data/data_source/api_provider.dart';

class HomeApiInterceptor extends Interceptor{

  String? myPath;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    /// give token to header
    String token = GetStorage().read(AppUtils.userTokenAccess);
    // print(token);
    options.headers["authorization"] = 'Bearer $token';

    print(options.path);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    // handle error separately
    DioErrorInterceptor.handleError(err);
  }
}

class DioErrorInterceptor {
  static Future<void> handleError(DioException err) async {
    if (err.response?.statusCode == 401) {
      if (GetStorage().read(AppUtils.userTokenAccess) != null) {
        var refreshToken = GetStorage().read(AppUtils.userTokenRefresh);

        Map<String, dynamic> refresh = {"refresh": refreshToken};

        try {
          var response = await AuthApiProvider().refreshToken(refresh);
          if (response is! DioException) {
            if (response.statusCode == 200) {
              GetStorage().write(
                  AppUtils.userTokenAccess, response.data['access']);
              GetStorage().write(
                  AppUtils.userTokenRefresh, response.data['refresh']);
            } else {
              // handle other error cases
            }
          } else {
            Get.offAllNamed(PagesRoutes.login);
          }
        } catch (e) {}
      }
    }
  }
}
