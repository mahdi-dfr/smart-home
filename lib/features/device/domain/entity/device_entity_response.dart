import '../../../device/data/model/device.dart';

class DeviceResponseEntity {
  int? id;
  String? name;
  String? deviceType;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? room;
  int? project;
  int? nodeProject;

  DeviceResponseEntity({this.id,
    this.name,
    this.deviceType,
    this.createdAt,
    this.deleteAt,
    this.updateAt,
    this.room,
    this.project,
    this.nodeProject});
}
