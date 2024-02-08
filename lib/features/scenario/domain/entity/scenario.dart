import '../../data/model/scenario.dart';

class ScenarioEntity {
  int? id;
  List<UserScenario>? user;
  String? type;
  String? status;
  int? device;
  int? project;

  ScenarioEntity(
      {this.id, this.user, this.type, this.status, this.device, this.project});
}