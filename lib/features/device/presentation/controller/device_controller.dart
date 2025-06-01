import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/features/device/domain/entity/device_entity.dart';
import 'package:turkeysh_smart_home/features/device/domain/entity/sensor_config.dart';
import 'package:turkeysh_smart_home/features/device/domain/usecase/device_usecase.dart';

import '../../../../core/resource/connection/mqtt_service.dart';
import '../../../../core/resource/data_state.dart';
import '../../../../core/resource/internet_controller.dart';
import '../../domain/entity/device_node_entity.dart';

class DeviceController extends GetxController {
  final DeviceUseCae _useCase;

  DeviceController(this._useCase);

  late TextEditingController deviceName;
  late TextEditingController sensorRange;
  RxList<DeviceEntity> roomsList = RxList();

  var isLoading = false.obs;
  var isDeviceLoading = false.obs;
  var isDeleteDeviceLoading = false.obs;

  /// این مقادیر کاملا مرتبط با بخش تننظیم ماکس یا مین سنسورها هستند
  List<String> sensorBoardList = []; /// سنسور ها بعد از قراخوانی همه ی تجهیزات داخل این لیست ریخته میشوند برای اینکه هنگام رفرش کردن وضعیت سنسور ها از این لیست استفاده کنیم
  List<String> sensorDeviceTypeList = []; /// سنسور ها بعد از قراخوانی همه ی تجهیزات داخل این لیست ریخته میشوند برای اینکه هنگام رفرش کردن وضعیت سنسور ها از این لیست استفاده کنیم
  List<DeviceEntity> relayDeviceList = [];
  /// این دوتا مپ برای این هستند که وقتی میخواهیم لیست کلید هارا در بخش تنظیم ماکس و مین سنسور بگیریم بتوتیم از اونجا به node id و  boardid دسترسی داشته باشیم
  Map<String, dynamic> deviceRelayNode = {};
  Map<String, dynamic> deviceRelayBoard = {};
  bool isMax = true;
  int selectedDeviceRelayBoard = -1;
  int selectedDeviceRelayNode = -1;
  String selectedRelayName = '';
  bool sensorConfigStatus = false;
  late TextEditingController sensorConfigValue; /// مقدار ماکزیمم یا مینیمم در کانفیگ سنسور
  List<String> deviceRelayName = [];
  RxList<SensorConfig> configList = RxList();
  ///


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
    sensorRange = TextEditingController();
    sensorConfigValue = TextEditingController();
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
        for (var element in deviceNodeList) {
          if (element.nodeType != null) {
            deviceNodeNames[
                '${element.boardProject?[0]['text']} - نود شماره: ${element.uniqueId}'] = {
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
      DataState<List<DeviceEntity>> localData =
          await _useCase.getLocalDevices(localProjectId, roomId!);
      if (localData is DataSuccess) {
        isDeviceLoading.value = false;
        deviceList.value = localData.data ?? [];
      }
    } else {
      if (Get.find<InternetController>().isConnected.value) {
        DataState<List<DeviceEntity>> dataState =
            await _useCase.getDevices(localProjectId, roomId!);

        if (dataState is DataSuccess) {
          relayDeviceList.clear();
          if (dataState.data != null) {
            deviceList.value = dataState.data ?? [];
            await _useCase.deleteDevicesFromLocal(localProjectId, roomId!);
            await _useCase.saveDevicesToLocal(dataState.data ?? []);
            for (int i = 0; i < dataState.data!.length; i++) {
              if (dataState.data![i].deviceType == '1' ||
                  dataState.data![i].deviceType == '2' ||
                  dataState.data![i].deviceType == '3') {
                sensorBoardList
                    .add(dataState.data![i].projectBoard!.uniqueId!.toString());
                sensorDeviceTypeList
                    .add(dataState.data![i].deviceType.toString());
              }
              if (dataState.data![i].deviceType == '0') {
                relayDeviceList.add(dataState.data![i]);
                sortDeviceRelayData(relayDeviceList);
              }
            }

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

  sortDeviceRelayData(List<DeviceEntity> devices){
    deviceRelayName.clear();
    deviceRelayBoard.clear();
    deviceRelayNode.clear();

    for(int i = 0; i < devices.length; i ++){
      deviceRelayBoard[devices[i].name!] = devices[i].projectBoard!.uniqueId;
      deviceRelayNode[devices[i].name!] = devices[i].nodeProject!.uniqueId!;
      deviceRelayName.add(devices[i].name!);
    }

  }

  Future<DataState<String>> deleteDevice(int id) async {
    isDeleteDeviceLoading.value = true;
    if (Get.find<InternetController>().isConnected.value) {
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


  sendSensorConfigMessage(int type, int boardId, String sensorName){
    if(sensorConfigValue.text.isNotEmpty && selectedDeviceRelayBoard != -1 && selectedDeviceRelayNode != -1){
      String projectName = GetStorage().read(AppUtils.projectNameConst);
      String username = GetStorage().read(AppUtils.username);
      String topic;
      SensorConfig sensorConfig;

      Map<String, dynamic> message = {};
      if (isMax) {
        topic = '$projectName/$username/sensor_ctrl_max';
        message = {
          'type' : 'sensor_ctrl_max',
          'sensor_id' : boardId,
          'data_type' : type,
          'max' : int.parse(sensorConfigValue.text),
          'board_id_r' : selectedDeviceRelayBoard,
          'node_id' : selectedDeviceRelayNode,
          'node_status' : sensorConfigStatus
        };
        sensorConfig = SensorConfig('Max', int.parse(sensorConfigValue.text), selectedRelayName, sensorConfigStatus, sensorName);
      }else{
        topic = '$projectName/$username/sensor_ctrl_min';
        message = {
          'type' : 'sensor_ctrl_min',
          'sensor_id' : boardId,
          'data_type' : type,
          'min' : int.parse(sensorConfigValue.text),
          'board_id_r' : selectedDeviceRelayBoard,
          'node_id' : selectedDeviceRelayNode,
          'node_status' : sensorConfigStatus
        };
        sensorConfig = SensorConfig('Min', int.parse(sensorConfigValue.text), selectedRelayName, sensorConfigStatus, sensorName);
      }


      _useCase.saveSensorConfigsToLocal(sensorConfig);
      sensorConfigValue.clear();
      selectedDeviceRelayBoard = -1;
      selectedDeviceRelayNode = -1;
      Get.back();
      print(message);
      Get.find<MqttService>().publishMessage(message, topic);
    }else{
      const CustomSnackBar.error(message: 'لطفا اطلاعات را کامل کنید');
    }
  }

  getSensorConfig() async {
    DataState<List<SensorConfig>> dataState = await _useCase.getLocalSensorConfigs();
    configList.clear();
    configList.value = dataState.data ?? [];

  }

  deleteConfigs(int id, bool isMax, int sensorId, int type, int index){
    _useCase.deleteSensorConfigsFromLocal(id);
    Map<String, dynamic> message;
    String projectName = GetStorage().read(AppUtils.projectNameConst);
    String username = GetStorage().read(AppUtils.username);
    String topic;
    if(isMax){
      topic = '$projectName/$username/sensor_ctrl_del_max';
      message = {
        'type' : 'sensor_ctrl_del_max',
        'sensor_id' : sensorId,
        'data_type' : type
      };
    }else{
      topic = '$projectName/$username/sensor_ctrl_del_min';
      message = {
        'type' : 'sensor_ctrl_del_min',
        'sensor_id' : sensorId,
        'data_type' : type
      };
    }
    configList.removeAt(index);
    print(message);
    Get.find<MqttService>().publishMessage(message, topic);
  }




  @override
  void dispose() {
    deviceName.dispose();
    sensorConfigValue.dispose();
    super.dispose();
  }
}
