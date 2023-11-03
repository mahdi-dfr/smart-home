import '../../../domain/entity/project_entity.dart';
import '../../../domain/entity/prooject_result_entity.dart';

class ProjectResponseModel extends ProjectEntity {
  int? count;
  String? next;
  String? previous;
  List<ProjectResults>? results;

  ProjectResponseModel({this.count, this.next, this.previous, this.results})
      : super(count: count, next: next, previous: previous, results: results);

  ProjectResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <ProjectResults>[];
      json['results'].forEach((v) {
        results!.add(ProjectResults.fromJson(v));
      });
    }
  }
}

class ProjectResults extends ProjectResultsEntity {
  int? id;
  String? name;
  String? address;
  String? createdAt;
  String? deleteAt;
  int? user;

  ProjectResults(
      {this.id,
      this.name,
      this.address,
      this.createdAt,
      this.deleteAt,
      this.user})
      : super(
          id: id,
          name: name,
          address: address,
          createdAt: createdAt,
          deleteAt: deleteAt,
          user: user,
        );

  ProjectResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    createdAt = json['created_at'];
    deleteAt = json['delete_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['delete_at'] = deleteAt;
    return data;
  }
}
