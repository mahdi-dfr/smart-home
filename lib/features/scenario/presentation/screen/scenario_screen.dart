import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/dimens.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/widget/drop_box.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/hardware_scenario_controller.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/software_controller.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/widget/hardware_pannel_item.dart';

import '../../../../core/constants/app_constant_data.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../mqtt_service.dart';
import '../widget/hardware_scenario_widget.dart';
import '../widget/panel_item.dart';
import '../widget/software_scenario_item.dart';
import '../widget/software_scenario_list.dart';

class ScenarioScreen extends StatelessWidget {
  ScenarioScreen({Key? key}) : super(key: key);

  final _controller = Get.find<HardwareScenarioController>();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

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
                      if (value == 'پنل دیواری') {
                        _controller.isHardwareScenario.value = true;
                      } else {
                        _controller.isHardwareScenario.value = false;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                _controller.isHardwareScenario.value
                    ? HardwareScenarioWidget()
                    : SoftwareScenarioListWidget(),
              ],
            );
          }),
        ),
      )),
    );
  }
}
