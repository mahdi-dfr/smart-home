import '../../../domain/entity/software/create_software_entity.dart';

class CreateSoftwareScenarioModel extends CreateSoftwareScenarioEntity {
  int? id;
  String? name;
  String? status;
  int? project;
  List<int>? device;

  CreateSoftwareScenarioModel({this.id, this.name, this.status, this.project, this.device})
      : super(
          id: id,
          name: name,
          status: status,
          project: project,
          device: device,
        );

  CreateSoftwareScenarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    project = json['project'];
    device = json['device'].cast<int>();
  }
}
