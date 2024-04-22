import 'package:dio/dio.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/features/scenario/data/data_source/api_provider.dart';
import 'package:turkeysh_smart_home/features/scenario/data/model/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/data/model/scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/hardware_message_entity.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/repostory/scenario_repository.dart';

import '../model/hardware_scenario_message.dart';

class ScenarioRepositoryImpl implements ScenarioRepository {
  final ScenarioApiProvider _apiProvider;

  ScenarioRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<CreateHardwareScenarioModel>> addNewHardwareScenario(
      Map<String, dynamic> data, int projectId) async {
    var response = await _apiProvider.setHardwareScenario(data, projectId);
    if (response is! DioException) {
      if (response.statusCode == 201) {
        CreateHardwareScenarioModel hardwareScenario =
            CreateHardwareScenarioModel.fromJson(response.data);
        return DataSuccess(hardwareScenario);
      } else {
        return DataFailed(response.message);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<String>> deleteHardwareScenario(int id) async {
    var response = await _apiProvider.deleteHardwareScenarioById(id);
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
  Future<DataState<List<RelayEntity>>> getAllRelays(
      int projectId, String type) async {
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
      print(response.error);
      print(response.message);
      print(response.response);
      return DataFailed(response.response.toString());
    }
  }

  @override
  Future<DataState<List<HardwareScenarioEntity>>> getHardwareScenario(
      int projectId, String type) async {
    var response = await _apiProvider.getHardwareScenarios(projectId, type);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        List<HardwareScenarioEntity> dataList = [];
        for (int i = 0; i < response.data.length; i++) {
          dataList.add(HardwareScenarioModel.fromJson(response.data[i]));
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
  Future<DataState<HardwareScenarioMessageEntity>> getHardwareMessage(
      int projectId, int scenarioId) async {
    var response =
        await _apiProvider.getHardwareScenarioMessage(projectId, scenarioId);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        HardwareScenarioMessageEntity entity =
            HardwareScenarioMessage.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }
}
