import '../../domain/entity/project_board_entity.dart';
import '../../domain/entity/project_board_resault.dart';

class ProjectBoard extends ProjectBoardEntity {
  int? count;
  String? next;
  String? previous;
  List<ProjectBoardResults>? results;

  ProjectBoard({this.count, this.next, this.previous, this.results})
      : super(
          count: count,
          next: next,
          previous: previous,
          results: results,
        );

  ProjectBoard.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <ProjectBoardResults>[];
      json['results'].forEach((v) {
        results!.add(ProjectBoardResults.fromJson(v));
      });
    }
  }
}

class ProjectBoardResults extends ProjectBoardResultsEntity {
  int? id;
  String? name;
  int? boardType;
  int? uniqueId;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? project;
  int? parentBoard;

  ProjectBoardResults(
      {this.id,
      this.name,
      this.boardType,
      this.uniqueId,
      this.createdAt,
      this.deleteAt,
      this.updateAt,
      this.project,
      this.parentBoard})
      : super(
          id: id,
          name: name,
          boardType: boardType,
          uniqueId: uniqueId,
          createdAt: createdAt,
          deleteAt: deleteAt,
          updateAt: updateAt,
          project: project,
          parentBoard: parentBoard,
        );

  ProjectBoardResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    boardType = json['board_type'];
    uniqueId = json['unique_id'];
    createdAt = json['created_at'];
    deleteAt = json['delete_at'];
    updateAt = json['update_at'];
    project = json['project'];
    parentBoard = json['parent_board'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['board_type'] = boardType;
    data['unique_id'] = uniqueId;
    data['created_at'] = createdAt;
    data['delete_at'] = deleteAt;
    data['update_at'] = updateAt;
    data['project'] = project;
    data['parent_board'] = parentBoard;
    return data;
  }
}
