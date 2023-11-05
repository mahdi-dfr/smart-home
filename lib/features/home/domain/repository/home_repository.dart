import '../../../../core/resource/data_state.dart';
import '../entity/room_entity.dart';
import '../entity/room_response_entity.dart';

abstract class HomeRepository{

  Future<DataState<RoomEntity>> createRoom(Map<String, dynamic> data);

  Future<DataState<RoomResponseEntity>> getRooms(int projectId);

  Future<DataState<RoomEntity>> updateRoom(Map<String, dynamic> data, int id);

  Future<DataState<String>> deleteRoom(int id, int projectId);


}