import 'package:turkeysh_smart_home/features/settings/domain/entity/control_board_entity.dart';
import 'package:turkeysh_smart_home/features/settings/domain/entity/project_board_entity.dart';

import '../../../../core/resource/data_state.dart';
import '../../../project/domain/entity/prooject_result_entity.dart';
import '../repository/project_board_repository.dart';

class ProjectBoardUseCase{
  ProjectBoardRepository _repository;

  ProjectBoardUseCase(this._repository);

  Future<DataState<String>> addProjectBoard(Map<String, dynamic> data){
    return _repository.createProjectBoard(data);
  }

  Future<DataState<ProjectBoardEntity>> getAllProjectsBoard(String page, String projectId){
    return _repository.getUserProjectsBoard(page, projectId);
  }

  Future<DataState<String>> deleteProjectBoardById(int id){
    return _repository.deleteUserProjectsBoard(id);
  }

  Future<DataState<String>> updateProjectBoard(Map<String, dynamic> data, int id){
    return _repository.updateUserProjectsBoard(data, id);
  }

  Future<DataState<ControlBoardEntity>> getControlBoards(String projectId){
    return _repository.getControlBoard(projectId);
  }


}