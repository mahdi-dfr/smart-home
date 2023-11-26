import '../../domain/entity/device_entity_response.dart';

class DeviceResponseModel extends DeviceResponseEntity {
  int? id;
  String? name;
  String? deviceType;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? room;
  int? project;
  int? nodeProject;

  DeviceResponseModel(
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

  DeviceResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deviceType = json['device_type'];
    createdAt = json['created_at'];
    deleteAt = json['delete_at'];
    updateAt = json['update_at'];
    room = json['room'];
    project = json['project'];
    nodeProject = json['node_project'];
  }

}
