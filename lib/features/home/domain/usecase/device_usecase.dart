import 'package:turkeysh_smart_home/features/home/domain/repository/home_repository.dart';

import '../../../../core/resource/data_state.dart';
import '../entity/device_entity.dart';
import '../entity/device_node_entity.dart';

class DeviceUseCae {
  final HomeRepository _repository;

  DeviceUseCae(this._repository);

  Future<DataState<DeviceEntity>> createDevice(
    Map<String, dynamic> data,
  ) {
    return _repository.createDevice(data);
  }

  Future<DataState<List<DeviceEntity>>> getDevices(int projectId, int room) {
    return _repository.getDevice(projectId, room);
  }

  Future<DataState<String>> deleteDevice(int id, int project, int room) {
    return _repository.deleteDevice(
      id,
      project,
      room,
    );
  }

  Future<DataState<List<DeviceNodeEntity>>> getDeviceNodes(
      int projectId, String node) {
    return _repository.getDeviceNode(projectId, node);
  }
}
