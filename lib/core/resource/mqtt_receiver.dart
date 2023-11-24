import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/device_controller.dart';

import '../../features/home/domain/entity/device_entity.dart';
import '../../test.dart';

class MqttReceiver extends GetxController {

  final _deviceController = Get.find<DeviceController>();
  final _mqttController = Get.find<MqttService>();

  var relayOneTime1 = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  sortMqttTopics() async {
    DataState<List<DeviceEntity>> dataState = await _deviceController
        .getAllDevises();
    if(dataState.data != null){
      if(dataState.data!.isNotEmpty){
        dataState.data?.forEach((element) {
          if(element.deviceType == '0'){
            _mqttController.subscribeMessage('relay11');
          }
        });
      }
    }
  }

}