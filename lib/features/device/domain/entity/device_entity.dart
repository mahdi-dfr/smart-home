import '../../data/model/device.dart';

class DeviceEntity {
  int? id;
  NodeProject? nodeProject;
  ProjectBoard? projectBoard;
  String? name;
  String? deviceType;
  int? eventId;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? room;
  int? project;

  DeviceEntity({
    this.id,
    this.nodeProject,
    this.projectBoard,
    this.name,
    this.deviceType,
    this.eventId,
    this.createdAt,
    this.deleteAt,
    this.updateAt,
    this.room,
    this.project,
  });
}

class NodeProjectEntity {
  int? id;
  int? nodeType;
  int? uniqueId;
  bool? isActive;
  int? boardProject;
  int? project;

  NodeProjectEntity(
      {this.id,
      this.nodeType,
      this.uniqueId,
      this.isActive,
      this.boardProject,
      this.project});
}
