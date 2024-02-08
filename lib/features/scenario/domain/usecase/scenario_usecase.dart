import 'package:turkeysh_smart_home/features/scenario/domain/repostory/scenario_repository.dart';

import '../../../../core/resource/data_state.dart';
import '../entity/relay.dart';
import '../entity/scenario.dart';

class ScenarioUseCase{
  final ScenarioRepository _repository;
  ScenarioUseCase(this._repository);

  Future<DataState<List<RelayEntity>>> getAllRelays(int projectId, String type){
    return _repository.getAllRelays(projectId, type);
  }

  Future<DataState<String>> deleteScenario(int id){
    return _repository.deleteScenario(id);
  }

  Future<DataState<String>> addNewScenario(List<dynamic> data){
    return _repository.addNewScenario(data);
  }

  Future<DataState<List<ScenarioEntity>>> getScenario(int projectId, String type){
    return _repository.getScenario(projectId, type);
  }
}