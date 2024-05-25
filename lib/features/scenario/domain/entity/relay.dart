import '../../../device/data/model/device.dart';

class RelayEntity {
  int? id;
  NodeProject? nodeProject;
  String? name;
  String? deviceType;
  int? eventId;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? room;
  int? project;

  RelayEntity({this.id,
    this.nodeProject,
    this.name,
    this.deviceType,
    this.eventId,
    this.createdAt,
    this.deleteAt,
    this.updateAt,
    this.room,
    this.project});
}