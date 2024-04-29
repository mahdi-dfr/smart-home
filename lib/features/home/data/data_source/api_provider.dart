import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class HomeApiProvider {
  final Dio _dio = Dio();

  /// create room
  Future<dynamic> createRoom(Map<String, dynamic> data) async {
    _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.post(
        UrlConstant.baseUrl + UrlConstant.room,
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

  /// get project room
  Future<dynamic> getProjectRoom(int projectId) async {
    _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.room,
        queryParameters: {'project': projectId},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getOneProjectRoom(int projectId, int roomId) async {
    _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.room+roomId.toString(),
        queryParameters: {'project': projectId},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  /// update project room
  Future<dynamic> updateRoomById(Map<String, dynamic> data, int id, int projectId ) async {
    _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.patch(
        '${UrlConstant.baseUrl}${UrlConstant.room}$id/',
        data: data,
        queryParameters: {'project': projectId},
        options: Options(responseType: ResponseType.json, method: 'PATCH'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  /// delete project room
  Future<dynamic> deleteRoomById(int id, int projectId) async {
    _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.delete(
        '${UrlConstant.baseUrl}${UrlConstant.room}$id/',
        queryParameters: {'project': projectId},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getDeviceNode(int projectId, String node) async {
    _dio.interceptors.add(HomeApiInterceptor());
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
    _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.device,
        queryParameters: {'project': projectId, 'room': room},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      print(projectId);
      print(room);
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> createDevice(Map<String, dynamic> data) async {
    _dio.interceptors.add(HomeApiInterceptor());
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
    _dio.interceptors.add(HomeApiInterceptor());
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
