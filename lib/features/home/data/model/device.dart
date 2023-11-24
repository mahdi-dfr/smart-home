import '../../domain/entity/device_entity.dart';

class DeviceModel extends DeviceEntity {
  int? id;
  String? name;
  String? deviceType;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? room;
  int? project;
  NodeProject? nodeProject;

  DeviceModel(
      {this.id,
      this.name,
      this.deviceType,
      this.createdAt,
      this.deleteAt,
      this.updateAt,
      this.room,
      this.project,
      this.nodeProject})
      : super(
          id: id,
          name: name,
          deviceType: deviceType,
          createdAt: createdAt,
          deleteAt: deleteAt,
          updateAt: updateAt,
          room: room,
          project: project,
          nodeProject: nodeProject,
        );

  DeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deviceType = json['device_type'];
    createdAt = json['created_at'];
    deleteAt = json['delete_at'];
    updateAt = json['update_at'];
    room = json['room'];
    project = json['project'];
    nodeProject = json['node_project'] != null
        ? NodeProject.fromJson(json['node_project'])
        : null;
  }
}

class NodeProject extends NodeProjectEntity {
  int? id;
  String? nodeType;
  int? uniqueId;
  bool? isActive;
  int? boardProject;
  int? project;

  NodeProject(
      {this.id,
      this.nodeType,
      this.uniqueId,
      this.isActive,
      this.boardProject,
      this.project})
      : super(
          id: id,
          nodeType: nodeType,
          uniqueId: uniqueId,
          isActive: isActive,
          boardProject: boardProject,
          project: project,
        );

  NodeProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeType = json['node_type'];
    uniqueId = json['unique_id'];
    isActive = json['is_active'];
    boardProject = json['board_project'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['node_type'] = nodeType;
    data['unique_id'] = uniqueId;
    data['is_active'] = isActive;
    data['board_project'] = boardProject;
    data['project'] = project;
    return data;
  }
}
