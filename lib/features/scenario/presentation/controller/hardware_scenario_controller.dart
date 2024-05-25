import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/usecase/scenario_usecase.dart';

import '../../../../core/constants/utils.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../data/model/hardware/hardware_scenario_message.dart';
import '../../domain/entity/hardware/hardware_message_entity.dart';
import 'base_scenario_controller.dart';

class HardwareScenarioController extends BaseScenarioController {
  final ScenarioUseCase _useCase;
  HardwareScenarioController(this._useCase);


  final projectId = GetStorage().read(AppUtils.projectIdConst);
  final projectName = GetStorage().read(AppUtils.projectNameConst);

  String? panelType;
  RxList<HardwareScenarioEntity> scenarioList = RxList();
  var isHardwareScenario = true.obs;
  Map<String, dynamic>? scenarioMessage = {};


  Future<DataState<List<HardwareScenarioEntity>>> getHardwareScenario(
      String type) async {
    isScenarioLoading.value = true;
    if (!Get.find<ConnectionController>().isConnected.value) {
      isScenarioLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
    DataState<List<HardwareScenarioEntity>> dataState = await _useCase
        .getHardwareScenario(projectId, type);
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

  Future<DataState<CreateHardwareScenarioModel>> setNewHardwareScenario() async {
    isLoading.value = true;
    if (!Get.find<ConnectionController>().isConnected.value) {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
    addNewData();

    if (scenarioData == {} ||
        deviceList.isEmpty ||
        scenarioOnOff == null) {
      isLoading.value = false;
      return const DataFailed('لطفا تمام اطلاعات را وارد نمایید');
    }
    DataState dataState = await _useCase.addNewHardwareScenario(scenarioData!);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        scenarioOnOff = null;
        isLoading.value = false;
        getHardwareScenario(panelType!);
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

  Future<DataState<String>> deleteHardwareScenario(String type) async {
    isDeleteLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState dataState = await _useCase.deleteHardwareScenario(projectId, type);
      if (dataState is DataSuccess) {
        isDeleteLoading.value = false;
        return const DataSuccess('سناریو با موفقیت حذف شد');
      } else {
        isDeleteLoading.value = false;
        print(dataState.error);
        return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
      }
    } else {
      isDeleteLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  Future<DataState<Map<String, dynamic>>> getHardwareScenarioMessage(
      int scenarioId) async {
    if (!Get.find<ConnectionController>().isConnected.value) {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
    DataState<HardwareScenarioMessageEntity> dataState =
        await _useCase.getHardwareScenarioMessage(projectId, scenarioId);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        isScenarioLoading.value = false;
        var scenarioMessageData = dataState.data!;

        scenarioMessage = {
          "type": scenarioMessageData.type,
          "key_num": scenarioMessageData.keyNum,
          "total_board_ids": scenarioMessageData.totalBoardIds,
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

  void addNewData() {
    scenarioData = {
      'name': scenarioName.text,
      'device': deviceList,
      'status': scenarioOnOff,
      'type': panelType,
      'project': projectId
    };
  }



  // removeData(int relayId){
  //   scenarioData?.removeWhere((element) => element.);
  // }

  changePanelType(String newPanelType) {
    panelType = newPanelType;
  }
}
