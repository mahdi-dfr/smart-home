import '../../data/model/project_board.dart';

class ProjectBoardEntity {
  int? count;
  String? next;
  String? previous;
  List<ProjectBoardResults>? results;

  ProjectBoardEntity({this.count, this.next, this.previous, this.results});
}