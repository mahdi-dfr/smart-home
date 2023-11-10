import 'package:turkeysh_smart_home/features/settings/domain/entity/control_board_entity.dart';
import 'package:turkeysh_smart_home/features/settings/domain/entity/project_board_entity.dart';

import '../../../../core/resource/data_state.dart';

abstract class ProjectBoardRepository{

  Future<DataState<String>> createProjectBoard(Map<String, dynamic> data);

  Future<DataState<ProjectBoardEntity>> getUserProjectsBoard(String page, String projectId);

  Future<DataState<String>> updateUserProjectsBoard(Map<String, dynamic> data, int id);

  Future<DataState<String>> deleteUserProjectsBoard(int id);

  Future<DataState<ControlBoardEntity>> getControlBoard(String projectId);


}