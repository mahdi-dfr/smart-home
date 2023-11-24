class ProjectBoardResultsEntity {
  int? id;
  String? name;
  int? boardType;
  int? uniqueId;
  String? createdAt;
  String? deleteAt;
  String? updateAt;
  int? project;
  int? parentBoard;

  ProjectBoardResultsEntity({this.id,
    this.name,
    this.boardType,
    this.uniqueId,
    this.createdAt,
    this.deleteAt,
    this.updateAt,
    this.project,
    this.parentBoard});

}