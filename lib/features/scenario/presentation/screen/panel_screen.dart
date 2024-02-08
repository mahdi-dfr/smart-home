import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/scenario_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';

class PanelScreen extends StatelessWidget {
  const PanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    Get.find<ScenarioController>().getScenario(
        Get.find<ScenarioController>().panelType!
    );

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
          Get.find<ScenarioController>().getAllRelays();
          Get.toNamed(PagesRoutes.chooseScenario);
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
          return Get.find<ScenarioController>().isScenarioLoading.value
              ? Center(
                  child: LoadingAnimationWidget.beat(
                      color: CustomColors.foregroundColor, size: 35),
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
                    SliverList.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                              width: width,
                              height: height / 12,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
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
                                    Container(
                                      width: width / 8,
                                      height: height / 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Get.find<ScenarioController>()
                                                    .scenarioList[index]
                                                    .status ==
                                                '1'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      child: const Icon(
                                        Icons.power_settings_new_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(Get.find<ScenarioController>()
                                                .scenarioList
                                                .value[index]
                                                .device
                                                .toString() +
                                            Get.find<ScenarioController>()
                                                .scenarioList
                                                .value[index]
                                                .status
                                                .toString() ??
                                        '')
                                  ],
                                ),
                              )),
                        );
                      },
                      itemCount:
                          Get.find<ScenarioController>().scenarioList.length,
                    )
                  ],
                );
        }),
      )),
    );
  }
}
