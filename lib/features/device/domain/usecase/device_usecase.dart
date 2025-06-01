import 'package:turkeysh_smart_home/features/device/domain/repository/device_repository.dart';

import '../../../../core/resource/data_state.dart';
import '../entity/device_entity.dart';
import '../entity/device_entity_response.dart';
import '../entity/device_node_entity.dart';
import '../entity/sensor_config.dart';

class DeviceUseCae {
  final DeviceRepository _repository;

  DeviceUseCae(this._repository);

  Future<DataState<DeviceResponseEntity>> createDevice(
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

  Future<DataState<String>> saveDevicesToLocal(List<DeviceEntity> devices){
    return _repository.saveDevicesToLocal(devices);
  }

  Future<DataState<List<DeviceEntity>>> getLocalDevices(int projectId, int roomId){
    return _repository.getLocalDevices(projectId, roomId);
  }

  Future<DataState<String>> deleteDevicesFromLocal(int projectId, int roomId){
    return _repository.deleteDevicesFromLocal(projectId, roomId);
  }




  Future<DataState<String>> saveSensorConfigsToLocal(SensorConfig configs) {
    return _repository.saveSensorConfigsToLocal(configs);
  }

  Future<DataState<List<SensorConfig>>> getLocalSensorConfigs(){
    return _repository.getLocalSensorConfigs();
  }

  Future<DataState<String>> deleteSensorConfigsFromLocal(int id){
    return _repository.deleteSensorConfigsFromLocal(id);
  }
}
