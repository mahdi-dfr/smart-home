import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/features/device/domain/entity/device_entity.dart';
import 'package:turkeysh_smart_home/features/device/domain/usecase/device_usecase.dart';

import '../../../../core/resource/internet_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/device_node_entity.dart';

class DeviceController extends GetxController {
  final DeviceUseCae _useCase;

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
  int? boardId;

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
      'project_board': boardId
    };
    if (Get.find<InternetController>().isConnected.value) {
      if (deviceName.text.isNotEmpty && deviceType != null && nodeProject != null) {
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
    DataState<List<DeviceNodeEntity>> dataState = await _useCase.getDeviceNodes(projectId, deviceType!);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        deviceNodeList.clear();
        deviceNodeNames.clear();

        deviceNodeList.value = dataState.data!;
        for (var element in deviceNodeList) {
          if (element.nodeType != null) {
            deviceNodeNames['${element.boardProject?[0]['text']} - نود شماره: ${element.uniqueId}'] = {
              'id': element.id,
              'boardId': element.boardProject?[0]['value']
            };
          }
        }

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

  Future<void> getAllDevises() async {
    isDeviceLoading.value = true;
    bool offlineMode = GetStorage().read(AppUtils.offlineMode) ?? false;
    var localProjectId = GetStorage().read(AppUtils.projectIdConst);

    if (offlineMode) {
      DataState<List<DeviceEntity>> localData = await _useCase.getLocalDevices(localProjectId, roomId!);
      if (localData is DataSuccess) {
        isDeviceLoading.value = false;
        deviceList.value = localData.data ?? [];
      }
    } else {
      if (Get.find<InternetController>().isConnected.value) {
        DataState<List<DeviceEntity>> dataState = await _useCase.getDevices(localProjectId, roomId!);

        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            deviceList.value = dataState.data ?? [];
            await _useCase.deleteDevicesFromLocal(localProjectId, roomId!);
            await _useCase.saveDevicesToLocal(dataState.data ?? []);

            isDeviceLoading.value = false;
          }
        } else {
          isDeviceLoading.value = false;
        }
      } else {
        isDeviceLoading.value = false;
      }
    }
  }

  Future<DataState<String>> deleteDevice(int id) async {
    isDeleteDeviceLoading.value = true;
    if (Get.find<InternetController>().isConnected.value) {
      DataState dataState = await _useCase.deleteDevice(id, GetStorage().read(AppUtils.projectIdConst), roomId!);
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

  filterDevicesBasedOnOneTime() {
    oneTimeDeviceList.clear();
    if (deviceList.isNotEmpty) {
      for (var element in deviceList) {
        if (element.deviceType == '0') {
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
