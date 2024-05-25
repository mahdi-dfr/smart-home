import 'package:dio/dio.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/features/home/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/home/data/model/room_response.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_response_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeApiProvider _apiProvider;

  HomeRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<RoomEntity>> createRoom(Map<String, dynamic> data) async {
    var response = await _apiProvider.createRoom(data);
    if (response is! DioException) {
      if (response.statusCode == 201) {
        RoomEntity entity = RoomResults.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.message);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> deleteRoom(int id, int projectId) async {
    var response = await _apiProvider.deleteRoomById(id, projectId);
    if (response is! DioException) {
      if (response.statusCode == 204) {
        return const DataSuccess('success');
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.toString());
    }
  }

  @override
  Future<DataState<RoomResponseEntity>> getRooms(int projectId) async {
    var response = await _apiProvider.getProjectRoom(projectId);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        RoomResponseEntity entity = RoomResponseModel.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<RoomEntity>> updateRoom(
      Map<String, dynamic> data, int id, int projectId) async {
    var response = await _apiProvider.updateRoomById(data, id, projectId);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        RoomEntity entity = RoomResults.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.message ?? 'error');
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }


  @override
  Future<DataState<RoomEntity>> getOneRoom(int projectId, int roomId) async {
    var response = await _apiProvider.getOneProjectRoom(projectId, roomId);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        RoomEntity entity = RoomResults.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }
}
