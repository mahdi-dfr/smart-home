import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class ProjectApiProvider {
  final Dio _dio = Dio();

  /// create project
  Future<dynamic> createProject(Map<String, dynamic> data) async {
    _dio.interceptors.add(ProjectApiInterceptor());
    try {
      var response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.project,
        data: data,
        options: Options(responseType: ResponseType.json, method: 'POST'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  /// get user projects
  Future<dynamic> getAllProjects() async {
    _dio.interceptors.add(ProjectApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.project,
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  /// update user projects
  Future<dynamic> updateProjectById(Map<String, dynamic> data, int id) async {
    _dio.interceptors.add(ProjectApiInterceptor());
    try {
      var response = await _dio.patch(
        '${UrlConstant.baseUrl}${UrlConstant.project}$id/',
        data: data,
        options: Options(responseType: ResponseType.json, method: 'PATCH'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  /// delete user projects
  Future<dynamic> deleteProjectById(int id) async {
    _dio.interceptors.add(ProjectApiInterceptor());
    try {
      var response = await _dio.delete(
        '${UrlConstant.baseUrl}${UrlConstant.project}$id/',
        options: Options(responseType: ResponseType.json, method: 'DELETE'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

}
