import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/device_entity.dart';
import 'package:turkeysh_smart_home/features/home/domain/usecase/device_usecase.dart';

import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/device_node_entity.dart';

class DeviceController extends GetxController {
  DeviceUseCae _useCase;

  DeviceController(this._useCase);

  late TextEditingController deviceName;
  RxList<DeviceEntity> roomsList = RxList();

  var isLoading = false.obs;
  var isDeviceLoading = false.obs;
  var isDeleteDeviceLoading = false.obs;
  var isGetNodesLoading = false.obs;
  String? deviceType;
  String? nodeProject;
  int? roomId;

  RxList<DeviceNodeEntity> deviceNodeList = RxList();
  RxList<DeviceEntity> deviceList = RxList();
  RxMap<String, dynamic> deviceNodeNames = RxMap();
  RxList<DeviceEntity> oneTimeDeviceList = RxList();


  @override
  void onInit() {
    deviceName = TextEditingController();
    super.onInit();
  }

  Future<DataState<String>> createNewDevice() async {
    isLoading.value = true;
    Map<String, dynamic> data = {
      'name': deviceName.text,
      'room': roomId,
      'project': GetStorage().read(AppUtils.projectIdConst),
      'device_type': deviceType,
      'node_project': nodeProject,
    };
    if (Get.find<ConnectionController>().isConnected.value) {
      if (deviceName.text.isNotEmpty &&
          deviceType != null &&
          nodeProject != null) {
        DataState dataState = await _useCase.createDevice(data);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            getAllDevises();
            deviceName.text = '';
            isLoading.value = false;
            return const DataSuccess('اطلاعات با موفقیت ذخیره شد');
          } else {
            isLoading.value = false;
            return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
          }
        } else {
          isLoading.value = false;
          return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
        }
      } else {
        isLoading.value = false;
        return const DataFailed('لطفا تمام اطلاعات را وارد نمایید');
      }
    } else {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  Future<DataState<List<DeviceNodeEntity>>> getDeviceNodes() async {
    isGetNodesLoading.value = true;
    int projectId = GetStorage().read(AppUtils.projectIdConst);
    DataState<List<DeviceNodeEntity>> dataState =
        await _useCase.getDeviceNodes(projectId, deviceType!);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        deviceNodeList.clear();
        deviceNodeNames.clear();

        deviceNodeList.value = dataState.data!;
        deviceNodeList.value.forEach((element) {
          if (element.nodeType != null) {
            deviceNodeNames['${element.nodeType!} ${element.uniqueId} - ${element.boardProject}'] =
                element.id;
          }
        });
        isGetNodesLoading.value = false;
        return DataSuccess(deviceNodeList);
      } else {
        isGetNodesLoading.value = false;
        return const DataFailed('err');
      }
    } else {
      isGetNodesLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
  }

  Future<DataState<List<DeviceEntity>>> getAllDevises() async {
    isDeviceLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState<List<DeviceEntity>> dataState = await _useCase.getDevices(
          GetStorage().read(AppUtils.projectIdConst), roomId!);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          deviceList.value = dataState.data ?? [];
          isDeviceLoading.value = false;
        }
        return DataSuccess(dataState.data);
      } else {
        isDeviceLoading.value = false;
        return const DataFailed('err');
      }
    } else {
      isDeviceLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
  }

  Future<DataState<String>> deleteDevice(int id) async {
    isDeleteDeviceLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState dataState = await _useCase.deleteDevice(
          id, GetStorage().read(AppUtils.projectIdConst), roomId!);
      if (dataState is DataSuccess) {
        getAllDevises();
        return const DataSuccess('تجهیز با موفقیت حذف شد');
      } else {
        isDeleteDeviceLoading.value = false;
        return DataFailed(dataState.error ?? 'خطا در ارسال اطلاعات');
      }
    } else {
      isDeleteDeviceLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  filterDevicesBasedOnOneTime(){
    oneTimeDeviceList.clear();
    if(deviceList.isNotEmpty){
      for (var element in deviceList) {
        if(element.deviceType == '0'){
          oneTimeDeviceList.add(element);
        }
      }
    }
  }

  @override
  void dispose() {
    deviceName.dispose();
    super.dispose();
  }
}
