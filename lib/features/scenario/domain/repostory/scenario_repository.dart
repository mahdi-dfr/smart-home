import 'package:turkeysh_smart_home/features/scenario/domain/entity/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/scenario.dart';

import '../../../../core/resource/data_state.dart';
import '../../data/model/hardware_scenario_message.dart';
import '../entity/hardware_message_entity.dart';
import '../entity/software_entity.dart';
import '../entity/software_message_entity.dart';

abstract class ScenarioRepository {
  Future<DataState<List<RelayEntity>>> getAllRelays(int projectId, String type);

  /// hardware scenario
  Future<DataState<String>> deleteHardwareScenario(int id);

  Future<DataState<CreateHardwareScenarioModel>> addNewHardwareScenario(
      Map<String, dynamic> data);

  Future<DataState<List<HardwareScenarioEntity>>> getHardwareScenario(
      int projectId, String type);

  Future<DataState<HardwareScenarioMessageEntity>> getHardwareMessage(
      int projectId, int scenarioId);

  /// software scenario
  Future<DataState<String>> deleteSoftwareScenario(int id);

  Future<DataState<String>> addNewSoftwareScenario(
      Map<String, dynamic> data);

  Future<DataState<List<SoftwareScenarioEntity>>> getSoftwareScenario(
      int projectId,);

  Future<DataState<SoftwareMessageEntity>> getSoftwareMessage(int scenarioId);
}
