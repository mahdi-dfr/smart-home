import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class ScenarioApiProvider {
  final Dio _dio = Dio();

  Future<dynamic> deleteScenarioById(int id,) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.delete(
        '${UrlConstant.baseUrl}${UrlConstant.scenario}$id/',
        options: Options(responseType: ResponseType.json, method: 'DELETE'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getRelayDevices(int projectId, String type) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.device,
        queryParameters: {'project': projectId, 'type': type},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getScenarios(int projectId, String type) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.scenario,
        queryParameters: {'project': projectId, 'type': type},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> setScenario(List<dynamic> data) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.scenario,
        options: Options(responseType: ResponseType.json, method: 'POST'),
        data: data
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }


}
