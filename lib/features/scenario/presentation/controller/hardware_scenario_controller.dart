import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/usecase/scenario_usecase.dart';

import '../../../../core/constants/utils.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import 'base_scenario_controller.dart';

class HardwareScenarioController extends BaseScenarioController {
  final ScenarioUseCase _useCase;

  HardwareScenarioController(this._useCase);

  final projectId = GetStorage().read(AppUtils.projectIdConst);
  TextEditingController scenarioName = TextEditingController();

  String? panelType;
  String? scenarioOnOff;
  RxList<RelayEntity> relayList = RxList();
  RxList<ScenarioEntity> scenarioList = RxList();
  RxList<int> deviceList = RxList();
  Map<String, dynamic>? scenarioData = {};

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

  Future<DataState<List<ScenarioEntity>>> getScenario(String type) async {
    isScenarioLoading.value = true;
    if (!Get.find<ConnectionController>().isConnected.value) {
      isScenarioLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
    DataState<List<ScenarioEntity>> dataState = await _useCase.getScenario(
        GetStorage().read(AppUtils.projectIdConst), type);
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

  Future<DataState<String>> setNewScenario() async {
    isLoading.value = true;
    if (!Get.find<ConnectionController>().isConnected.value) {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
    addNewData();
    if (scenarioData == {} ||
        scenarioName.text.isEmpty ||
        deviceList.isEmpty ||
        scenarioOnOff == null) {
      isLoading.value = false;
      return const DataFailed('لطفا تمام اطلاعات را وارد نمایید');
    }
    DataState dataState = await _useCase.addNewScenario(scenarioData!);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        scenarioOnOff = null;
        isLoading.value = false;
        getScenario(panelType!);
        clearData();
        return const DataSuccess('اطلاعات با موفقیت ذخیره شد');
      } else {
        isLoading.value = false;
        return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
      }
    } else {
      isLoading.value = false;
      return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
    }
  }

  Future<DataState<String>> deleteScenario(int id) async {
    isDeleteLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState dataState = await _useCase.deleteScenario(id);
      if (dataState is DataSuccess) {
        getScenario(panelType!);
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
      'type': panelType,
      'project': projectId
    };
  }

  void clearData() {
    scenarioData?.clear();
    scenarioName.clear();
    deviceList.clear();
    scenarioOnOff = null;
  }

  // removeData(int relayId){
  //   scenarioData?.removeWhere((element) => element.);
  // }

  changePanelType(String newPanelType) {
    panelType = newPanelType;
  }
}
