import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:turkeysh_smart_home/core/resource/isar_controller.dart';
import 'package:turkeysh_smart_home/features/device/data/data_source/api_provider.dart';

import '../../../../core/resource/data_state.dart';
import '../../domain/entity/device_entity.dart';
import '../../domain/entity/device_entity_response.dart';
import '../../domain/entity/device_node_entity.dart';
import '../../domain/repository/device_repository.dart';
import '../model/device.dart';
import '../model/device_node.dart';
import '../model/device_response.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  final DeviceApiProvider _apiProvider;
  final IsarController _isarController;

  DeviceRepositoryImpl(this._apiProvider, this._isarController);

  @override
  Future<DataState<DeviceResponseEntity>> createDevice(Map<String, dynamic> data) async {
    var response = await _apiProvider.createDevice(data);
    if (response is! DioException) {
      if (response.statusCode == 201) {
        DeviceResponseEntity entity = DeviceResponseModel.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.message);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> deleteDevice(int id, int projectId, int room) async {
    var response = await _apiProvider.deleteDevice(id, projectId, room);
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
  Future<DataState<List<DeviceNodeEntity>>> getDeviceNode(int projectId, String node) async {
    var response = await _apiProvider.getDeviceNode(projectId, node);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        List<DeviceNodeEntity> dataList = [];
        for (int i = 0; i < response.data.length; i++) {
          dataList.add(DeviceNodeModel.fromJson(response.data[i]));
        }
        return DataSuccess(dataList);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<List<DeviceEntity>>> getDevice(int projectId, int room) async {
    var response = await _apiProvider.getDevices(projectId, room);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        List<DeviceEntity> dataList = [];
        for (int i = 0; i < response.data.length; i++) {
          dataList.add(DeviceModel.fromJson(response.data[i]));
        }
        return DataSuccess(dataList);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> deleteDevicesFromLocal(int projectId, int roomId) async {
    try {
      await _isarController.isar.writeTxn(() async {
        await _isarController.isar.deviceEntitys
            .filter()
            .roomEqualTo(roomId)
            .and()
            .projectEqualTo(projectId)
            .deleteAll();
      });
      return const DataSuccess('success');
    } catch (err) {
      return DataFailed(err.toString());
    }
  }

  @override
  Future<DataState<List<DeviceEntity>>> getLocalDevices(int projectId, int roomId) async {
    try {
      List<DeviceEntity> projects = await _isarController.isar.deviceEntitys
          .filter()
          .roomEqualTo(roomId)
          .and()
          .projectEqualTo(projectId)
          .findAll();
      return DataSuccess(projects);
    } catch (err) {
      return const DataFailed('err');
    }
  }

  @override
  Future<DataState<String>> saveDevicesToLocal(List<DeviceEntity> devices) async {
    try {
      await _isarController.isar.writeTxn(() async {
        await _isarController.isar.deviceEntitys.putAll(devices);
      });
      return const DataSuccess('success');
    } catch (err) {
      return DataFailed(err.toString());
    }
  }
}
