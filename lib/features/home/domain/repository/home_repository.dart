
import '../../../../core/resource/data_state.dart';
import '../entity/room_entity.dart';
import '../entity/room_response_entity.dart';

abstract class HomeRepository{

  Future<DataState<RoomEntity>> createRoom(Map<String, dynamic> data);

  Future<DataState<RoomResponseEntity>> getRooms(int projectId);

  Future<DataState<RoomEntity>> getOneRoom(int projectId, int roomId);

  Future<DataState<RoomEntity>> updateRoom(Map<String, dynamic> data, int id, int projectId);

  Future<DataState<String>> deleteRoom(int id, int projectId);

  /// offline methods
  Future<DataState<String>> saveRoomToLocal(List<RoomEntity> rooms);

  Future<DataState<List<RoomEntity>>> getLocalRoom(int projectId);

  Future<DataState<String>> deleteRoomFromLocal(int projectId);


}