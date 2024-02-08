import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/scenario.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/usecase/scenario_usecase.dart';

import '../../../../core/constants/utils.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';

class ScenarioController extends GetxController{
  final ScenarioUseCase _useCase;
  ScenarioController(this._useCase);

  final projectId = GetStorage().read(AppUtils.projectIdConst);
  var isRelayLoading = false.obs;
  var isScenarioLoading = false.obs;
  var isLoading = false.obs;
  RxList<RelayEntity> relayList = RxList();
  RxList<ScenarioEntity> scenarioList = RxList();
  String? panelType;
  String? scenarioOnOff;
  Map<String, dynamic>? newData;
  List<Map<String, dynamic>>? scenarioData = [];


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
      if (scenarioData!.isEmpty || scenarioData == []) {
        isLoading.value = false;
        return const DataFailed('لطفا تمام اطلاعات را وارد نمایید');
      }
        DataState dataState = await _useCase.addNewScenario(scenarioData!);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            isLoading.value = false;
            getScenario(panelType!);
            scenarioData?.clear();
            newData?.clear();
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

  addNewData(int relayId){
    newData = {
      'device': relayId,
      'status': scenarioOnOff,
      'type': panelType,
      'project': projectId
    };
    print(scenarioOnOff);
    if(newData != null){
      scenarioData!.add(newData!);
    }

  }

  // removeData(int relayId){
  //   scenarioData?.removeWhere((element) => element.);
  // }

  changePanelType(String newPanelType){
    panelType = newPanelType;
  }
}