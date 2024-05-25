import '../../../device/data/model/device.dart';
import '../../domain/entity/relay.dart';

class RelayModel extends RelayEntity {
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

  RelayModel(
      {this.id,
      this.nodeProject,
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
          name: name,
          deviceType: deviceType,
          eventId: eventId,
          createdAt: createdAt,
          deleteAt: deleteAt,
          updateAt: updateAt,
          room: room,
          project: project,
        );

  RelayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeProject = json['node_project'] != null
        ? NodeProject.fromJson(json['node_project'])
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

