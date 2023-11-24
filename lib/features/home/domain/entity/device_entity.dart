import '../../data/model/device.dart';

class DeviceEntity {
  int? id;
  String? name;
  String? deviceType;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? room;
  int? project;
  NodeProject? nodeProject;

  DeviceEntity({this.id,
    this.name,
    this.deviceType,
    this.createdAt,
    this.deleteAt,
    this.updateAt,
    this.room,
    this.project,
    this.nodeProject});
}

class NodeProjectEntity {
  int? id;
  String? nodeType;
  int? uniqueId;
  bool? isActive;
  int? boardProject;
  int? project;

  NodeProjectEntity({this.id,
    this.nodeType,
    this.uniqueId,
    this.isActive,
    this.boardProject,
    this.project});

}