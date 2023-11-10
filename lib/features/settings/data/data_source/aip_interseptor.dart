import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';


class ProjectBoardApiInterceptor extends Interceptor{

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

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   super.onError(err, handler);
  //
  //
  //   /// get new access token if previous token is expired
  //   if (err.response!.statusCode == 401) {
  //     if (GetStorage().read(AppUtils.userTokenAccess) != null &&
  //         GetStorage().read(AppUtils.userTokenRefresh) != null) {
  //       var refreshToken = GetStorage().read(AppUtils.userTokenRefresh);
  //
  //       Map<String, dynamic> refresh = {"refresh": refreshToken};
  //
  //       try {
  //         AuthApiProvider().refreshToken(refresh).then((response) async {
  //           if (response is DioException) {
  //             DioException er = response;
  //             if (response != null) {
  //               if (er.response?.statusCode == 401) {
  //                 Get.back();
  //               }
  //             }
  //           } else {
  //             if (response.statusCode == 200) {
  //               GetStorage().write(
  //                   AppUtils.userTokenAccess, response.data['access']);
  //             }
  //           }
  //         });
  //       } catch (e) {
  //       }
  //     } else {
  //       Get.to('/');
  //     }
  //   }
  //
  //   if (err.response!.statusCode == 500 ||
  //       err.response!.statusCode == 503) {
  //     Get.snackbar('خطا', 'خطا در اتصال به سرور');
  //   }
  //
  //
  //
  //
  //
  // }

}