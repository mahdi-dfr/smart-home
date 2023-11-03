import 'package:turkeysh_smart_home/features/project/domain/entity/project_entity.dart';
import 'package:turkeysh_smart_home/features/project/domain/entity/prooject_result_entity.dart';
import 'package:turkeysh_smart_home/features/project/domain/repository/project_repository.dart';
import '../../../../core/resource/data_state.dart';

class ProjectUseCase{
  ProjectRepository _repository;

  ProjectUseCase(this._repository);

  Future<DataState<ProjectResultsEntity>> addProject(Map<String, dynamic> data){
    return _repository.createProject(data);
  }

  Future<DataState<ProjectEntity>> getAllProjects(){
    return _repository.getUserProjects();
  }

  Future<DataState<String>> deleteProjectById(int id){
    return _repository.deleteUserProjects(id);
  }

  Future<DataState<ProjectResultsEntity>> updateProject(Map<String, dynamic> data, int id){
    return _repository.updateUserProjects(data, id);
  }


}