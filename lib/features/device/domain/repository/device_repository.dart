import '../../../../core/resource/data_state.dart';
import '../entity/device_entity.dart';
import '../entity/device_entity_response.dart';
import '../entity/device_node_entity.dart';

abstract class DeviceRepository {

  Future<DataState<List<DeviceNodeEntity>>> getDeviceNode(int projectId, String node);

  Future<DataState<String>> deleteDevice(int id, int projectId, int room);

  Future<DataState<DeviceResponseEntity>> createDevice(Map<String, dynamic> data);

  Future<DataState<List<DeviceEntity>>> getDevice(int projectId, int room);

  /// offline methods
  Future<DataState<String>> saveDevicesToLocal(List<DeviceEntity> devices);

  Future<DataState<List<DeviceEntity>>> getLocalDevices(int projectId, int roomId);

  Future<DataState<String>> deleteDevicesFromLocal(int projectId, int roomId);
}
