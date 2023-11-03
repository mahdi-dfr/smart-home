import '../../data/model/room_response.dart';

class RoomResponseEntity {
  int? count;
  String? next;
  String? previous;
  List<RoomResults>? results;

  RoomResponseEntity({this.count, this.next, this.previous, this.results});
}