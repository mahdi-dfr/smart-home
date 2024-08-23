import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/core/resource/isar_controller.dart';
import 'package:turkeysh_smart_home/features/project/data/model/response/project_model.dart';
import 'package:turkeysh_smart_home/features/project/domain/entity/project_entity.dart';
import 'package:turkeysh_smart_home/features/project/domain/repository/project_repository.dart';

import '../../domain/entity/prooject_result_entity.dart';
import '../data_source/api_provider.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  final ProjectApiProvider _apiProvider;
  final IsarController _isarController;

  ProjectRepositoryImpl(this._apiProvider, this._isarController);

  @override
  Future<DataState<ProjectResultsEntity>> createProject(Map<String, dynamic> data) async {
    var response = await _apiProvider.createProject(data);
    if (response is! DioException) {
      if (response.statusCode == 201) {
        ProjectResultsEntity entity = ProjectResults.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.message);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<ProjectEntity>> getUserProjects() async {
    var response = await _apiProvider.getAllProjects();
    if (response is! DioException) {
      if (response.statusCode == 200) {
        ProjectEntity entity = ProjectResponseModel.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> deleteUserProjects(int id) async {
    var response = await _apiProvider.deleteProjectById(id);
    if (response is! DioException) {
      if (response.statusCode == 204) {
        return const DataSuccess('success');
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.toString());
    }
  }

  @override
  Future<DataState<ProjectResultsEntity>> updateUserProjects(Map<String, dynamic> data, int id) async {
    var response = await _apiProvider.updateProjectById(data, id);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        ProjectResultsEntity entity = ProjectResults.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.message ?? 'error');
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<List<ProjectResultsEntity>>> getLocalProject() async {
    try {
      List<ProjectResultsEntity> projects = await _isarController.isar.projectResultsEntitys.where().findAll();
      return DataSuccess(projects);
    } catch (err) {
      return const DataFailed('err');
    }
  }

  @override
  Future<DataState<String>> saveProjectToLocal(List<ProjectResultsEntity> project) async {
    try {
      await _isarController.isar.writeTxn(() async {
        await _isarController.isar.projectResultsEntitys.putAll(project);
      });
      return const DataSuccess('success');
    } catch (err) {
      return DataFailed(err.toString());
    }
  }

  @override
  Future<DataState<String>> deleteProjectFromLocal() async {
    try {
      await _isarController.isar.writeTxn(() async {
        await _isarController.isar.projectResultsEntitys.where().deleteAll();
      });
      return const DataSuccess('success');
    } catch (err) {
      return DataFailed(err.toString());
    }
  }
}
