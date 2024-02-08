import 'package:turkeysh_smart_home/features/scenario/domain/entity/scenario.dart';

class ScenarioModel extends ScenarioEntity {
  int? id;
  List<UserScenario>? user;
  String? type;
  String? status;
  int? device;
  int? project;

  ScenarioModel(
      {this.id, this.user, this.type, this.status, this.device, this.project})
      : super(
          id: id,
          user: user,
          type: type,
          status: status,
          device: device,
          project: project,
        );

  ScenarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['user'] != null) {
      user = <UserScenario>[];
      json['user'].forEach((v) {
        user!.add(UserScenario.fromJson(v));
      });
    }
    type = json['type'];
    status = json['status'];
    device = json['device'];
    project = json['project'];
  }
}

class UserScenario {
  int? value;
  String? text;

  UserScenario({this.value, this.text});

  UserScenario.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }
}
