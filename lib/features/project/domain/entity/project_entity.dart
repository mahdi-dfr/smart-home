import '../../data/model/response/project_model.dart';

class ProjectEntity {
  int? count;
  String? next;
  String? previous;
  List<ProjectResults>? results;

  ProjectEntity({this.count, this.next, this.previous, this.results});
}