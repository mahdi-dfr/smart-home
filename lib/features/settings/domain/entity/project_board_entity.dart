import 'package:turkeysh_smart_home/features/settings/domain/entity/project_board_resault.dart';

import '../../data/model/project_board.dart';

class ProjectBoardEntity {
  int? count;
  String? next;
  String? previous;
  List<ProjectBoardResultsEntity>? results;

  ProjectBoardEntity({this.count, this.next, this.previous, this.results});
}