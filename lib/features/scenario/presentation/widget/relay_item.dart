import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:turkeysh_smart_home/features/scenario/domain/entity/relay.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/base_scenario_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/styles.dart';
import '../controller/hardware_scenario_controller.dart';
import '../controller/software_controller.dart';

class RelayItemScenario extends StatelessWidget {
  RelayItemScenario({Key? key, required this.index,}) : super(key: key);

  final int index;
  final _hardwareController = Get.find<HardwareScenarioController>();
  final _softwareController = Get.find<SoftwareScenarioController>();

  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    
    return Container(
        width: width,
        height: height / 12,
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(
              AppDimensions.borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundCheckBox(
                size: 30,
                checkedColor: CustomColors.foregroundColor,
                onTap: (value) {
                  if (value!) {
                    if(_hardwareController.isHardwareScenario.value){
                      _hardwareController.deviceList.value.add(
                          _softwareController.relayList[index].id!);
                    }else{
                      _softwareController.deviceList.value.add(
                          _softwareController.relayList[index].id!);
                    }
                  } else {}
                },
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                _softwareController.relayList.value[index].name ??
                    '',
                style: AppStyles.style6,
              )
            ],
          ),
        ));
  }
}
