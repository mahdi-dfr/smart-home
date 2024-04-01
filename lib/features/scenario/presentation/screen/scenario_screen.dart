import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:turkeysh_smart_home/core/constants/dimens.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/widget/drop_box.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/hardware_scenario_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../widget/panel_item.dart';

class ScenarioScreen extends StatelessWidget {
  ScenarioScreen({Key? key}) : super(key: key);

  final _controller = Get.find<HardwareScenarioController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .sizeOf(context)
        .width;
    var height = MediaQuery
        .sizeOf(context)
        .height;

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: 150,
        titleWidget: const Text(
          'سناریو ها',
          style: AppStyles.appbarTitleStyle,
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Obx(() {
                return Column(
                  children: [
                    CustomDropDown(
                        items: AppUtils.scenarioTypeList,
                        title: 'نوع سناریو',
                        width: width,
                        height: height / 12,
                        onPressed: (value) {
                          if(value == 'پنل دیواری'){
                            _controller.isHardwareScenario.value = true;
                          }else{
                            _controller.isHardwareScenario.value = false;
                          }

                        }),

                    const SizedBox(height: 12,),

                    _controller.isHardwareScenario.value ? Column(
                      children: [
                        PanelItem(title: 'پنل یک', onItemPressed: () async {
                          await _controller.changePanelType('1');
                          Get.toNamed(PagesRoutes.panelScreen);
                        },),
                        PanelItem(title: 'پنل دو', onItemPressed: () async {
                          await _controller.changePanelType('2');
                          Get.toNamed(PagesRoutes.panelScreen);
                        },),
                        PanelItem(title: 'پنل سه', onItemPressed: () {
                          _controller.changePanelType('3');
                          Get.toNamed(PagesRoutes.panelScreen);
                        },),
                        PanelItem(title: 'پنل چهار', onItemPressed: () {
                          _controller.changePanelType('4');
                          Get.toNamed(PagesRoutes.panelScreen);
                        },),

                      ],
                    ) : PanelItem(
                      title: 'ساخت سناریوی نرم افزاری', onItemPressed: () {
                      Get.toNamed(PagesRoutes.panelScreen);
                    },),
                  ],
                );
              }),
            ),
          )),
    );
  }
}
