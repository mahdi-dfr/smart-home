class SoftwareScenarioEntity {
  int? id;
  String? name;
  String? status;
  int? project;
  List<int>? device;

  SoftwareScenarioEntity(
      {this.id, this.name, this.status, this.project, this.device});
}