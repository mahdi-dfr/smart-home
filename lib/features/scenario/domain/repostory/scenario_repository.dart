import 'package:turkeysh_smart_home/features/scenario/domain/entity/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/scenario.dart';

import '../../../../core/resource/data_state.dart';

abstract class ScenarioRepository{

  Future<DataState<List<RelayEntity>>> getAllRelays(int projectId, String type);

  Future<DataState<String>> deleteScenario(int id);

  Future<DataState<String>> addNewScenario(List<dynamic> data);

  Future<DataState<List<ScenarioEntity>>> getScenario(int projectId, String type);
}