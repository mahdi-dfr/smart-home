import '../../../../core/resource/data_state.dart';
import '../entity/project_entity.dart';
import '../entity/prooject_result_entity.dart';

abstract class ProjectRepository {
  /// online methods
  Future<DataState<ProjectResultsEntity>> createProject(Map<String, dynamic> data);

  Future<DataState<ProjectEntity>> getUserProjects();

  Future<DataState<ProjectResultsEntity>> updateUserProjects(Map<String, dynamic> data, int id);

  Future<DataState<String>> deleteUserProjects(int id);

  /// offline methods
  Future<DataState<String>> saveProjectToLocal(List<ProjectResultsEntity> project);

  Future<DataState<List<ProjectResultsEntity>>> getLocalProject();

  Future<DataState<String>> deleteProjectFromLocal();
}
