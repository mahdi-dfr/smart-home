import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/core/widget/custom_button.dart';
import 'package:turkeysh_smart_home/core/widget/text_field.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/hardware_scenario_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/drop_box.dart';

class ChooseScenarioScreen extends StatelessWidget {
  ChooseScenarioScreen({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Stack(
            children: [
              Obx(() {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              children: [
                                TextFieldBox(
                                  title: 'نام سناریو',
                                  height: height / 12,
                                  controller: _controller.scenarioName,
                                ),
                                CustomDropDown(
                                    items: const ['روشن', 'خاموش'],
                                    title: 'نوع سناریو',
                                    width: width,
                                    height: height / 12,
                                    onPressed: (value) {
                                      if (value == 'روشن') {
                                        _controller.scenarioOnOff = '1';
                                      } else {
                                        _controller.scenarioOnOff = '0';
                                      }
                                    }),
                              ],
                            ))),
                    SliverList.builder(
                      itemBuilder: (context, index) {
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
                                        _controller.deviceList.value.add(
                                            _controller.relayList[index].id!);
                                      } else {}
                                    },
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    _controller.relayList.value[index].name ??
                                        '',
                                    style: AppStyles.style6,
                                  )
                                ],
                              ),
                            ));
                      },
                      itemCount: _controller.relayList.length,
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: height / 11,
                      ),
                    )
                  ],
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  return CustomButton(
                    loading: _controller.isLoading.value,
                    onClick: () {
                      _controller.setNewScenario().then((value) {
                        if (value is DataSuccess) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message: value.data ?? 'ذخیره شد',
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: value.error ?? 'خطا در ارسال اطلاعات',
                            ),
                          );
                        }
                      });
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
