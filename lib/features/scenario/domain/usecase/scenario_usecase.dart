import 'package:turkeysh_smart_home/features/scenario/domain/repostory/scenario_repository.dart';

import '../../../../core/resource/data_state.dart';
import '../../data/model/hardware/hardware_scenario_message.dart';
import '../entity/hardware/hardware_message_entity.dart';
import '../entity/relay.dart';
import '../entity/scenario.dart';
import '../entity/software/create_software_entity.dart';
import '../entity/software/software_entity.dart';
import '../entity/software/software_message_entity.dart';

class ScenarioUseCase {
  final ScenarioRepository _repository;

  ScenarioUseCase(this._repository);

  /// hardware

  Future<DataState<List<RelayEntity>>> getAllRelays(
      int projectId, String type) {
    return _repository.getAllRelays(projectId, type);
  }

  Future<DataState<String>> deleteHardwareScenario( int projectId, String type) {
    return _repository.deleteHardwareScenario(projectId, type);
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

  // software:

  Future<DataState<String>> deleteSoftwareScenario(int id) {
    return _repository.deleteSoftwareScenario(id);
  }

  Future<DataState<CreateSoftwareScenarioEntity>> addNewSoftwareScenario(
      Map<String, dynamic> data) {
    return _repository.addNewSoftwareScenario(data);
  }

  Future<DataState<List<SoftwareScenarioEntity>>> getSoftwareScenario(
      int projectId) {
    return _repository.getSoftwareScenario(projectId);
  }

  Future<DataState<SoftwareMessageEntity>> getSoftwareScenarioMessage(int scenarioId) {
    return _repository.getSoftwareMessage(scenarioId);
  }
}
