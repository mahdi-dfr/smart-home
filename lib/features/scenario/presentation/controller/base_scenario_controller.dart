import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class BaseScenarioController extends GetxController{


  var isScenarioLoading = false.obs;
  var isLoading = false.obs;
  var isDeleteLoading = false.obs;

  TextEditingController scenarioName = TextEditingController();
  String? scenarioOnOff;
  RxList<int> deviceList = RxList();
  Map<String, dynamic>? scenarioData = {};


  void clearData() {
    scenarioData?.clear();
    scenarioName.clear();
    deviceList.clear();
    scenarioOnOff = null;
  }






}