import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constant_data.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/routes.dart';
import '../controller/hardware_scenario_controller.dart';
import 'hardware_pannel_item.dart';

class HardwareScenarioWidget extends StatelessWidget {
  HardwareScenarioWidget({
    Key? key,
  }) : super(key: key);

  final _controller = Get.find<HardwareScenarioController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Container(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      height: height * 0.45,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2, color: CustomColors.foregroundColor)),
      child: Center(
        child: CustomScrollView(
          slivers: [
            SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return HardwarePannelItem(
                    title: pannelScenarioNumberList[index],
                    onClick: () {
                      _controller.changePanelType((index+1).toString());
                      Get.find<HardwareScenarioController>().getAllRelays();
                      Get.toNamed(PagesRoutes.chooseScenario);
                    }, onLongClick: () {  },
                  );
                },
                itemCount: 4)
          ],
        ),
      ),
    );
  }
}
