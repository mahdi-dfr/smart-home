import 'package:turkeysh_smart_home/features/home/domain/entity/device_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/device_node_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_response_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/repository/home_repository.dart';
import '../../../../core/resource/data_state.dart';

class RoomUseCase{
  HomeRepository _repository;

  RoomUseCase(this._repository);

  Future<DataState<RoomEntity>> addRoom(Map<String, dynamic> data){
    return _repository.createRoom(data);
  }

  Future<DataState<RoomResponseEntity>> getAllRooms(int projectId){
    return _repository.getRooms(projectId);
  }

  Future<DataState<String>> deleteRoomById(int id, int projectId){
    return _repository.deleteRoom(id, projectId);
  }

  Future<DataState<RoomEntity>> updateRoom(Map<String, dynamic> data, int id, int projectId){
    return _repository.updateRoom(data, id, projectId);
  }

  Future<DataState<RoomEntity>> getOneRoom(int projectId, int roomId){
    return _repository.getOneRoom(projectId, roomId);
  }


}