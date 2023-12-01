import 'package:get/get.dart';

class DeviceHelperController extends GetxController{
  var isOneTimeRelayExpand = false.obs;
  var isSwitchClicked = false.obs;

  RxList<int> daysOnList = RxList();
  RxList<int> daysOffList = RxList();

  var hourOn = ''.obs;
  var minuteOn = ''.obs;
  var hourOff = ''.obs;
  var minuteOff = ''.obs;

  removeAllTimes(){
    hourOn.value = '';
    minuteOn.value = '';
    hourOff.value = '';
    minuteOff.value = '';
    daysOnList.value = [];
    daysOffList.value = [];
  }
}