import 'package:turkeysh_smart_home/features/home/domain/entity/device_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/device_node_entity.dart';

import '../../../../core/resource/data_state.dart';
import '../entity/room_entity.dart';
import '../entity/room_response_entity.dart';

abstract class HomeRepository{

  Future<DataState<RoomEntity>> createRoom(Map<String, dynamic> data);

  Future<DataState<RoomResponseEntity>> getRooms(int projectId);

  Future<DataState<RoomEntity>> getOneRoom(int projectId, int roomId);

  Future<DataState<RoomEntity>> updateRoom(Map<String, dynamic> data, int id, int projectId);

  Future<DataState<String>> deleteRoom(int id, int projectId);

  Future<DataState<List<DeviceNodeEntity>>> getDeviceNode(int projectId, String node);

  Future<DataState<String>> deleteDevice(int id, int projectId, int room);

  Future<DataState<DeviceEntity>> createDevice(Map<String, dynamic> data);

  Future<DataState<List<DeviceEntity>>> getDevice(int projectId, int room);


}