class SoftwareScenarioEntity {
  int? id;
  String? name;
  String? status;
  int? project;
  int? uniqueId;
  List<int>? device;

  SoftwareScenarioEntity(
      {this.id, this.name, this.status, this.project, this.device, this.uniqueId});
}