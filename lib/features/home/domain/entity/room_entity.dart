import 'package:isar/isar.dart';
part 'room_entity.g.dart';

@collection
class RoomEntity {
  int? id;
  Id isarId = Isar.autoIncrement;
  String? name;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? project;

  RoomEntity({
    this.id,
    this.name,
    this.createdAt,
    this.deleteAt,
    this.updateAt,
    this.project});
}