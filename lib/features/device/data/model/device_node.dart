import 'package:turkeysh_smart_home/features/device/data/model/device.dart';

import '../../domain/entity/device_node_entity.dart';

class DeviceNodeModel extends DeviceNodeEntity{
  int? id;
  int? boardProject;
  int? uniqueId;
  bool? isActive;
  int? nodeType;
  int? project;

  DeviceNodeModel({this.id,
    this.boardProject,
    this.uniqueId,
    this.isActive,
    this.nodeType,
    this.project}) :super(
    id: id,
    boardProject: boardProject,
    uniqueId: uniqueId,
    isActive: isActive,
    nodeType: nodeType,
    project: project,
  );

  DeviceNodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boardProject = json['board_project'];
    uniqueId = json['unique_id'];
    isActive = json['is_active'];
    nodeType = json['node_type'];
    project = json['project'];
  }

}

