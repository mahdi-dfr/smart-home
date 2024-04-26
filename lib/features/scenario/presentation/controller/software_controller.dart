import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/software_entity.dart';

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
  RxList<RelayEntity> relayList = RxList();
  RxList<SoftwareScenarioEntity> scenarioList = RxList();



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

  // Future<DataState<String>> setNewSoftwareScenario() async {
  //   isLoading.value = true;
  //   if (!Get.find<ConnectionController>().isConnected.value) {
  //     isLoading.value = false;
  //     return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
  //   }
  //   addNewData();
  //   if (scenarioData == {} ||
  //       scenarioName.text.isEmpty ||
  //       deviceList.isEmpty ||
  //       scenarioOnOff == null) {
  //     isLoading.value = false;
  //     return const DataFailed('لطفا تمام اطلاعات را وارد نمایید');
  //   }
  //   DataState dataState = await _useCase.addNewHardwareScenario(scenarioData!);
  //   if (dataState is DataSuccess) {
  //     if (dataState.data != null) {
  //       scenarioOnOff = null;
  //       isLoading.value = false;
  //       getHardwareScenario(panelType!);
  //       clearData();
  //       return DataSuccess(dataState.data);
  //     } else {
  //       isLoading.value = false;
  //       return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
  //     }
  //   } else {
  //     isLoading.value = false;
  //     return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
  //   }
  // }


}