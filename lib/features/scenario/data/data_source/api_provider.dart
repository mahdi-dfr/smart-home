import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class ScenarioApiProvider {
  final Dio _dio = Dio();

  Future<dynamic> deleteHardwareScenarioById(
    int id,
  ) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.delete(
        '${UrlConstant.baseUrl}${UrlConstant.hardwareScenario}$id/',
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

  Future<dynamic> getHardwareScenarios(int projectId, String type) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.hardwareScenario,
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

  Future<dynamic> setHardwareScenario(Map<String, dynamic> data,) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.post(
          UrlConstant.baseUrl + UrlConstant.hardwareScenario,
          options: Options(responseType: ResponseType.json, method: 'POST'),
          data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getHardwareScenarioMessage(
      int projectId, int scenarioId) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
          UrlConstant.baseUrl + UrlConstant.hardwareScenarioMessage,
          options: Options(responseType: ResponseType.json, method: 'GET'),
          queryParameters: {
            'project': projectId,
            'scenario': scenarioId,
          });
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }





  /// software:

  Future<dynamic> deleteSoftwareScenarioById(
      int id,
      ) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.delete(
        '${UrlConstant.baseUrl}${UrlConstant.softwareScenario}$id/',
        options: Options(responseType: ResponseType.json, method: 'DELETE'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getSoftwareScenarios(int projectId) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.softwareScenario,
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

  Future<dynamic> setSoftwareScenario(Map<String, dynamic> data,) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.post(
          UrlConstant.baseUrl + UrlConstant.softwareScenario,
          options: Options(responseType: ResponseType.json, method: 'POST'),
          data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getSoftwareScenarioMessage(int scenarioId) async {
    _dio.interceptors.add(ScenarioApiInterceptor());
    try {
      var response = await _dio.get(
          '${UrlConstant.baseUrl}${UrlConstant.softwareScenarioMessage}/$scenarioId',
          options: Options(responseType: ResponseType.json, method: 'GET'),);
      print(response);
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }
}
