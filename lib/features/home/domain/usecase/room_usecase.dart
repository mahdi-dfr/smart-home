
import 'package:turkeysh_smart_home/features/home/domain/entity/room_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_response_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/repository/home_repository.dart';
import '../../../../core/resource/data_state.dart';

class RoomUseCase{
  final HomeRepository _repository;

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

  Future<DataState<String>> saveRoomToLocal(List<RoomEntity> rooms){
    return _repository.saveRoomToLocal(rooms);
  }

  Future<DataState<List<RoomEntity>>> getLocalRoom(int projectId){
    return _repository.getLocalRoom(projectId);
  }

  Future<DataState<String>> deleteRoomFromLocal(int projectId){
    return _repository.deleteRoomFromLocal(projectId);
  }


}