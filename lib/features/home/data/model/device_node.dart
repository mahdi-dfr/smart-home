import '../../domain/entity/device_node_entity.dart';

class DeviceNodeModel extends DeviceNodeEntity {
  int? id;
  int? uniqueId;
  bool? isActive;
  String? nodeType;
  int? boardProject;
  int? project;

  DeviceNodeModel(
      {this.id,
      this.uniqueId,
      this.isActive,
      this.nodeType,
      this.boardProject,
      this.project})
      : super(
          id: id,
          uniqueId: uniqueId,
          isActive: isActive,
          nodeType: nodeType,
          boardProject: boardProject,
          project: project,
        );

  DeviceNodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    isActive = json['is_active'];
    nodeType = json['node_type'];
    boardProject = json['board_project'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['is_active'] = isActive;
    data['node_type'] = nodeType;
    data['board_project'] = boardProject;
    data['project'] = project;
    return data;
  }
}
