import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/software_entity.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/software_message_entity.dart';

import '../../../../core/constants/utils.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/relay.dart';
import '../../domain/usecase/scenario_usecase.dart';
import 'base_scenario_controller.dart';

class SoftwareScenarioController extends BaseScenarioController{

  final ScenarioUseCase _useCase;
  SoftwareScenarioController(this._useCase);


  final projectId = GetStorage().read(AppUtils.projectIdConst);
  RxList<SoftwareScenarioEntity> scenarioList = RxList();

  RxList<RelayEntity> relayList = RxList();
  var isRelayLoading = false.obs;
  Map<String, dynamic>? scenarioMessage = {};
  final projectName = GetStorage().read(AppUtils.projectNameConst);


  Future<DataState<List<RelayEntity>>> getAllRelays() async {
    isRelayLoading.value = true;
    if (!Get.find<ConnectionController>().isConnected.value) {
      isRelayLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
    DataState<List<RelayEntity>> dataState = await _useCase.getAllRelays(
        GetStorage().read(AppUtils.projectIdConst), '0');
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        relayList.value = dataState.data ?? [];
        isRelayLoading.value = false;
      }
      return DataSuccess(dataState.data);
    } else {
      isRelayLoading.value = false;
      return const DataFailed('err');
    }
  }


  Future<DataState<List<SoftwareScenarioEntity>>> getSoftwareScenario() async {
    isScenarioLoading.value = true;
    if (!Get.find<ConnectionController>().isConnected.value) {
      isScenarioLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
    DataState<List<SoftwareScenarioEntity>> dataState = await _useCase
        .getSoftwareScenario(projectId);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        scenarioList.value = dataState.data ?? [];
        isScenarioLoading.value = false;
      }
      return DataSuccess(dataState.data);
    } else {
      isScenarioLoading.value = false;
      return const DataFailed('err');
    }
  }

  Future<DataState<String>> setNewSoftwareScenario() async {
    isLoading.value = true;
    if (!Get.find<ConnectionController>().isConnected.value) {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
    addNewData();
    print(scenarioData);
    if (scenarioData == {} ||
        scenarioName.text.isEmpty ||
        deviceList.isEmpty ||
        scenarioOnOff == null) {
      isLoading.value = false;
      return const DataFailed('لطفا تمام اطلاعات را وارد نمایید');
    }
    DataState dataState = await _useCase.addNewSoftwareScenario(scenarioData!);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        scenarioOnOff = null;
        isLoading.value = false;
        getSoftwareScenario();
        clearData();
        return DataSuccess(dataState.data);
      } else {
        isLoading.value = false;
        return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
      }
    } else {
      isLoading.value = false;
      return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
    }
  }

  Future<DataState<Map<String, dynamic>>> getSoftwareScenarioMessage(
      int scenarioId) async {
    if (!Get.find<ConnectionController>().isConnected.value) {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
    DataState<SoftwareMessageEntity> dataState =
    await _useCase.getSoftwareScenarioMessage(scenarioId);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        isScenarioLoading.value = false;
        var scenarioMessageData = dataState.data!;

        scenarioMessage = {
          "type": scenarioMessageData.type,
          "scenario_id": scenarioId,
          "total_board_ids_used": scenarioMessageData.totalBoardIdsUsed,
          "node_ids": scenarioMessageData.nodeIds,
          "status": scenarioMessageData.status
        };
      }
      return DataSuccess(scenarioMessage);
    } else {
      isScenarioLoading.value = false;
      return const DataFailed('err');
    }
  }

  Future<DataState<String>> deleteSoftwareScenario(int id) async {
    isDeleteLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState dataState = await _useCase.deleteSoftwareScenario(id);
      if (dataState is DataSuccess) {
        getSoftwareScenario();
        isDeleteLoading.value = false;
        return const DataSuccess('سناریو با موفقیت حذف شد');
      } else {
        isDeleteLoading.value = false;
        return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
      }
    } else {
      isDeleteLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  void addNewData() {
    scenarioData = {
      'name': scenarioName.text,
      'device': deviceList,
      'status': scenarioOnOff,
      'project': projectId
    };
  }



}