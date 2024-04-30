import '../../../domain/entity/software/software_entity.dart';

class SoftwareScenarioModel extends SoftwareScenarioEntity {
  int? id;
  String? name;
  String? status;
  int? project;
  List<int>? device;

  SoftwareScenarioModel(
      {this.id, this.name, this.status, this.project, this.device})
      : super(
          id: id,
          name: name,
          status: status,
          project: project,
          device: device,
        );

  SoftwareScenarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    project = json['project'];
    device = json['device'].cast<int>();
  }
}
