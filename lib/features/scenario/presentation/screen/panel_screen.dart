import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/hardware_scenario_controller.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/software_controller.dart';
import 'package:turkeysh_smart_home/mqtt_service.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../widget/software_scenario_item.dart';

class PanelScreen extends StatelessWidget {
  PanelScreen({Key? key}) : super(key: key);

  final _softwareController = Get.find<SoftwareScenarioController>();
  final _mqttController = Get.find<MqttService>();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    _softwareController.getSoftwareScenario();

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: 150,
        titleWidget: const Text(
          'سناریو ها',
          style: AppStyles.appbarTitleStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(PagesRoutes.chooseSoftwareScenario);
        },
        backgroundColor: CustomColors.foregroundColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Obx(() {
          return Get.find<SoftwareScenarioController>().isScenarioLoading.value
              ? Center(
                  child: LoadingAnimationWidget.beat(color: CustomColors.foregroundColor, size: 35),
                )
              : CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'لیست سناریو های پنل',
                        style: AppStyles.style6,
                      ),
                    )),
                    _softwareController.scenarioList.value.isNotEmpty
                        ? SliverList.builder(
                            itemBuilder: (context, index) {
                              return SoftwareScenarioItem(
                                index: index,
                                onItemClicked: () {
                                  askDialog('فعال کردن سناریو', 'آیا مطمئن هستید؟', () {
                                    Get.back();
                                    _mqttController.publishMessage(
                                        {
                                          'type':'run_software_scenario',
                                          'scenario_id': _softwareController.scenarioList.value[index].uniqueId,
                                        },
                                        _softwareController.projectName +
                                            '/' +
                                            GetStorage().read(AppUtils.username) +
                                            '/' +
                                            'add_software_scenario');
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      const CustomSnackBar.success(
                                        message: 'سناریو با موفقیت فعال شد',
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            itemCount: _softwareController.scenarioList.length,
                          )
                        : SliverToBoxAdapter(
                            child: Center(
                              child: Lottie.asset(Images.empty, width: MediaQuery.sizeOf(context).width / 2),
                            ),
                          )
                  ],
                );
        }),
      )),
    );
  }
}
