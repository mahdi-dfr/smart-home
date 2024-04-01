import 'package:dio/dio.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/features/scenario/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/scenario/data/model/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/data/model/scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/repostory/scenario_repository.dart';

class ScenarioRepositoryImpl implements ScenarioRepository{
  final ScenarioApiProvider _apiProvider;

  ScenarioRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<String>> addNewScenario(Map<String,dynamic> data) async {
    var response = await _apiProvider.setScenario(data);
    if (response is! DioException) {
      if (response.statusCode == 201) {
        return const DataSuccess('success');
      } else {
        return DataFailed(response.message);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> deleteScenario(int id) async {
    var response = await _apiProvider.deleteScenarioById(id);
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
  Future<DataState<List<RelayEntity>>> getAllRelays(int projectId, String type) async {
    var response = await _apiProvider.getRelayDevices(projectId, type);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        List<RelayEntity> dataList = [];
        for (int i = 0; i < response.data.length; i++) {
          dataList.add(RelayModel.fromJson(response.data[i]));
        }
        return DataSuccess(dataList);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<List<ScenarioEntity>>> getScenario(int projectId, String type) async {
    var response = await _apiProvider.getScenarios(projectId, type);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        List<ScenarioEntity> dataList = [];
        print(response.data);
        for (int i = 0; i < response.data.length; i++) {
          dataList.add(ScenarioModel.fromJson(response.data[i]));
        }
        return DataSuccess(dataList);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

}