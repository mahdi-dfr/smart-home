import 'package:dio/dio.dart';

import '../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class DeviceApiProvider{
  final Dio _dio = Dio();


  Future<dynamic> getDeviceNode(int projectId, String node) async {
    _dio.interceptors.add(DeviceApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.deviceNode,
        queryParameters: {'project': projectId, 'node': node},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getDevices(int projectId, int room) async {
    _dio.interceptors.add(DeviceApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.device,
        queryParameters: {'project': projectId, 'room': room},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> createDevice(Map<String, dynamic> data) async {
    _dio.interceptors.add(DeviceApiInterceptor());
    try {
      var response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.device,
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

  Future<dynamic> deleteDevice(int id, int projectId, int room) async {
    _dio.interceptors.add(DeviceApiInterceptor());
    try {
      var response = await _dio.delete(
        '${UrlConstant.baseUrl}${UrlConstant.device}$id/',
        queryParameters: {'project': projectId, 'room': room},
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