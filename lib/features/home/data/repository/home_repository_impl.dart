import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/features/home/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/home/data/model/room_response.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_response_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/repository/home_repository.dart';

import '../../../../core/resource/isar_controller.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeApiProvider _apiProvider;
  final IsarController _isarController;

  HomeRepositoryImpl(this._apiProvider, this._isarController);

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
  Future<DataState<RoomEntity>> updateRoom(Map<String, dynamic> data, int id, int projectId) async {
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

  @override
  Future<DataState<String>> deleteRoomFromLocal(int projectId) async {
    try {
      await _isarController.isar.writeTxn(() async {
        await _isarController.isar.roomEntitys.filter().projectEqualTo(projectId).deleteAll();
      });
      return const DataSuccess('success');
    } catch (err) {
      return DataFailed(err.toString());
    }
  }

  @override
  Future<DataState<List<RoomEntity>>> getLocalRoom(int projectId) async {
    try {
      List<RoomEntity> rooms = await _isarController.isar.roomEntitys.filter().projectEqualTo(projectId).findAll();
      return DataSuccess(rooms);
    } catch (err) {
      return const DataFailed('err');
    }
  }

  @override
  Future<DataState<String>> saveRoomToLocal(List<RoomEntity> rooms) async {
    try {
      await _isarController.isar.writeTxn(() async {
        await _isarController.isar.roomEntitys.putAll(rooms);
      });
      return const DataSuccess('success');
    } catch (err) {
      return DataFailed(err.toString());
    }
  }
}
