import '../../../../core/resource/data_state.dart';
import '../entity/project_entity.dart';
import '../entity/prooject_result_entity.dart';

abstract class ProjectRepository{

  Future<DataState<ProjectResultsEntity>> createProject(Map<String, dynamic> data);

  Future<DataState<ProjectEntity>> getUserProjects();

  Future<DataState<ProjectResultsEntity>> updateUserProjects(Map<String, dynamic> data, int id);

  Future<DataState<String>> deleteUserProjects(int id);


}