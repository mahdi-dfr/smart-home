import '../../data/model/hardware_scenario_model.dart';

class HardwareScenarioEntity {
  int? id;
  String? name;
  List<UserScenario>? user;
  String? type;
  String? status;
  List<int>? device;
  int? project;

  HardwareScenarioEntity(
      {this.id, this.user, this.type, this.status, this.device, this.project});
}