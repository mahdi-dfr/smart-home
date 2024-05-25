import 'package:get/get.dart';

import '../../../../mqtt_service.dart';

class RelayController extends GetxController{

  var isPowerButtonExpanded = false.obs;
  var isDeviceSwitchOn = false.obs;
  var isPowerSwitchOn = false.obs;
  var isItemExpanded = false.obs;
  int? boardUniqueId;
  int? nodeId;

  final _controller = Get.find<MqttService>();


  setRelaySwitchValue() {
    for (var element in _controller.relayDataList) {
      print(element.boardId);
      if (element.boardId == boardUniqueId) {
        switch (nodeId) {
          case 1:
            isPowerSwitchOn.value = element.key1 ?? false;
          case 2:
            isPowerSwitchOn.value = element.key2 ?? false;
          case 3:
            isPowerSwitchOn.value = element.key3 ?? false;
          case 4:
            isPowerSwitchOn.value = element.key4 ?? false;
          case 5:
            isPowerSwitchOn.value = element.key5 ?? false;
          case 6:
            isPowerSwitchOn.value = element.key6 ?? false;
          case 7:
            isPowerSwitchOn.value = element.key7 ?? false;
          case 8:
            isPowerSwitchOn.value = element.key8 ?? false;
          case 9:
            isPowerSwitchOn.value = element.key9 ?? false;
          case 10:
            isPowerSwitchOn.value = element.key10 ?? false;
          case 11:
            isPowerSwitchOn.value = element.key11 ?? false;
          case 12:
            isPowerSwitchOn.value = element.key12 ?? false;
        }
      }
    }
  }

}