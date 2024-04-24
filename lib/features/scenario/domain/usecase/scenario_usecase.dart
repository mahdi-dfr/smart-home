import 'package:turkeysh_smart_home/features/scenario/domain/repostory/scenario_repository.dart';

import '../../../../core/resource/data_state.dart';
import '../../data/model/hardware_scenario_message.dart';
import '../entity/hardware_message_entity.dart';
import '../entity/relay.dart';
import '../entity/scenario.dart';

class ScenarioUseCase {
  final ScenarioRepository _repository;

  ScenarioUseCase(this._repository);

  Future<DataState<List<RelayEntity>>> getAllRelays(
      int projectId, String type) {
    return _repository.getAllRelays(projectId, type);
  }

  Future<DataState<String>> deleteHardwareScenario(int id) {
    return _repository.deleteHardwareScenario(id);
  }

  Future<DataState<CreateHardwareScenarioModel>> addNewHardwareScenario(
      Map<String, dynamic> data) {
    return _repository.addNewHardwareScenario(data);
  }

  Future<DataState<List<HardwareScenarioEntity>>> getHardwareScenario(
      int projectId, String type) {
    return _repository.getHardwareScenario(projectId, type);
  }

  Future<DataState<HardwareScenarioMessageEntity>> getHardwareScenarioMessage(
      int projectId, int scenarioId) {
    return _repository.getHardwareMessage(projectId, scenarioId);
  }
}
