import 'package:dio/dio.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/features/settings/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/settings/data/model/project_board.dart';
import 'package:turkeysh_smart_home/features/settings/domain/entity/control_board_entity.dart';
import 'package:turkeysh_smart_home/features/settings/domain/entity/project_board_entity.dart';

import '../../domain/entity/project_board_resault.dart';
import '../../domain/repository/project_board_repository.dart';
import '../model/control_board.dart';

class ProjectBoardRepositoryImpl extends ProjectBoardRepository {
  final ProjectBoardApiProvider _apiProvider;

  ProjectBoardRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<ProjectBoardResultsEntity>> createProjectBoard(
      Map<String, dynamic> data) async {
    var response = await _apiProvider.createProjectBoard(data);
    if (response is! DioException) {
      if (response.statusCode == 201) {
        ProjectBoardResultsEntity entity = ProjectBoardResults.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.message);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> deleteUserProjectsBoard(int id) async {
    var response = await _apiProvider.deleteProjectBoardById(id);
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
  Future<DataState<ProjectBoardEntity>> getUserProjectsBoard(
      String page, String projectId) async {
    var response = await _apiProvider.getAllProjectBoards(page, projectId);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        ProjectBoardEntity entity = ProjectBoard.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> updateUserProjectsBoard(
      Map<String, dynamic> data, int id) async {
    var response = await _apiProvider.updateProjectBoardById(data, id);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        return const DataSuccess('success');
      } else {
        return DataFailed(response.message ?? 'error');
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<ControlBoardEntity>> getControlBoard(String projectId) async {
    var response = await _apiProvider.getControlBoards(projectId);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        ControlBoardEntity entity = ControlBoard.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> createProjectNode(Map<String, dynamic> data) async {
     var response = await _apiProvider.createProjectNode(data);
    if (response is! DioException) {
    if (response.statusCode == 201) {
    return const DataSuccess('success');
    } else {
    return const DataFailed('error');
    }
    } else {
    return DataFailed(response.response.toString());
    }
  }
}
