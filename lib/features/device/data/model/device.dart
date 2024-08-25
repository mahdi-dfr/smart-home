import 'package:isar/isar.dart';
import 'package:turkeysh_smart_home/features/device/domain/entity/device_entity.dart';
part 'device.g.dart';

class DeviceModel extends DeviceEntity {
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

  DeviceModel(
      {this.id,
      this.nodeProject,
      this.projectBoard,
      this.name,
      this.deviceType,
      this.eventId,
      this.createdAt,
      this.deleteAt,
      this.updateAt,
      this.room,
      this.project})
      : super(
          id: id,
          nodeProject: nodeProject,
          projectBoard: projectBoard,
          name: name,
          deviceType: deviceType,
          eventId: eventId,
          createdAt: createdAt,
          deleteAt: deleteAt,
          updateAt: updateAt,
          room: room,
          project: project,
        );

  DeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeProject = json['node_project'] != null
        ? NodeProject.fromJson(json['node_project'])
        : null;
    projectBoard = json['project_board'] != null
        ? ProjectBoard.fromJson(json['project_board'])
        : null;
    name = json['name'];
    deviceType = json['device_type'];
    eventId = json['event_id'];
    createdAt = json['created_at'];
    deleteAt = json['delete_at'];
    updateAt = json['update_at'];
    room = json['room'];
    project = json['project'];
  }
}

@embedded
class NodeProject {
  int? id;
  int? uniqueId;
  bool? isActive;
  int? nodeType;
  ProjectBoard? boardProject;
  int? project;

  NodeProject(
      {this.id,
      this.uniqueId,
      this.isActive,
      this.nodeType,
      this.boardProject,
      this.project});

  NodeProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    isActive = json['is_active'];
    nodeType = json['node_type'];
    boardProject = json['project_board'] != null
        ? ProjectBoard.fromJson(json['project_board'])
        : null;
    project = json['project'];
  }
}

@embedded
class ProjectBoard {
  int? id;
  int? controlSmsBoard;
  int? controlWifiBoard;
  String? name;
  int? uniqueId;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? boardType;
  int? project;
  List<int>? node;

  ProjectBoard(
      {this.id,
      this.controlSmsBoard,
      this.controlWifiBoard,
      this.name,
      this.uniqueId,
      this.createdAt,
      this.deleteAt,
      this.updateAt,
      this.boardType,
      this.project,
      this.node});

  ProjectBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    controlSmsBoard = json['control_sms_board'];
    controlWifiBoard = json['control_wifi_board'];
    name = json['name'];
    uniqueId = json['unique_id'];
    createdAt = json['created_at'];
    deleteAt = json['delete_at'];
    updateAt = json['update_at'];
    boardType = json['board_type'];
    project = json['project'];
    node = json['node'].cast<int>();
  }
}
