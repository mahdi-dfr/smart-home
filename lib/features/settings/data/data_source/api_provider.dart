import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class ProjectBoardApiProvider {
  final Dio _dio = Dio();

  Future<dynamic> createProjectBoard(Map<String, dynamic> data) async {
    _dio.interceptors.add(ProjectBoardApiInterceptor());
    try {
      var response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.projectBoard,
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

  Future<dynamic> getAllProjectBoards(String page, String projectId) async {
    _dio.interceptors.add(ProjectBoardApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.projectBoard,
        queryParameters: {'project': projectId, 'page': page},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> updateProjectBoardById(Map<String, dynamic> data, int id) async {
    _dio.interceptors.add(ProjectBoardApiInterceptor());
    try {
      var response = await _dio.patch(
        '${UrlConstant.baseUrl}${UrlConstant.projectBoard}$id/',
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

  Future<dynamic> deleteProjectBoardById(int id) async {
    _dio.interceptors.add(ProjectBoardApiInterceptor());
    try {
      var response = await _dio.delete(
        '${UrlConstant.baseUrl}${UrlConstant.projectBoard}$id/',
        options: Options(responseType: ResponseType.json, method: 'DELETE'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getControlBoards(String projectId) async {
    _dio.interceptors.add(ProjectBoardApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.controlBoards,
        queryParameters: {'project': projectId,},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

}
