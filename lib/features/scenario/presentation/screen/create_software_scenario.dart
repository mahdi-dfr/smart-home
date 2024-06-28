import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/core/widget/custom_button.dart';
import 'package:turkeysh_smart_home/core/widget/text_field.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/hardware_scenario_controller.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/software_controller.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/widget/relay_item.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/drop_box.dart';
import '../../../../core/resource/mqtt_service.dart';
import '../controller/base_scenario_controller.dart';

class ChooseSoftwareScenarioScreen extends StatelessWidget {
  ChooseSoftwareScenarioScreen({Key? key}) : super(key: key);

  final _hardwareController = Get.find<HardwareScenarioController>();
  final _softwareController = Get.find<SoftwareScenarioController>();
  final _mqttController = Get.find<MqttService>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    // _softwareController.getAllRelays();

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: 150,
        titleWidget: const Text(
          'سناریوی نرم افزاری',
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
                                  controller: _hardwareController.isHardwareScenario.value
                                      ? _hardwareController.scenarioName
                                      : _softwareController.scenarioName,
                                ),
                                CustomDropDown(
                                    items: const ['روشن', 'خاموش'],
                                    title: 'نوع سناریو',
                                    width: width,
                                    height: height / 12,
                                    onPressed: (value) {
                                      if (value == 'روشن') {
                                        if (_hardwareController.isHardwareScenario.value) {
                                          _hardwareController.scenarioOnOff = '1';
                                        } else {
                                          _softwareController.scenarioOnOff = '1';
                                        }
                                      } else {
                                        if (_hardwareController.isHardwareScenario.value) {
                                          _hardwareController.scenarioOnOff = '0';
                                        } else {
                                          _softwareController.scenarioOnOff = '0';
                                        }
                                      }
                                    }),
                              ],
                            ))),
                    _softwareController.isRelayLoading.value
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: LoadingAnimationWidget.beat(color: CustomColors.foregroundColor, size: 35),
                            ),
                          )
                        : SliverList.builder(
                            itemBuilder: (context, index) {
                              return RelayItemScenario(index: index);
                            },
                            itemCount: _softwareController.relayList.length,
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
                    loading: _hardwareController.isLoading.value,
                    onClick: () {
                      onSoftwareScenarioCreated(context);
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

  onSoftwareScenarioCreated(BuildContext context) {
    _softwareController.setNewSoftwareScenario().then((value) {
      if (value is DataSuccess) {
        Get.back();

        _softwareController.getSoftwareScenarioMessage(value.data!.id!).then((value) {
          print(value.data);
          if (value is DataSuccess) {
            _mqttController.publishMessage(
                value.data!,
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
          } else {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: value.error ?? 'خطا در ارسال اطلاعات',
              ),
            );
          }
        });

        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'اطلاعات با موفقیت ذخیره شد',
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
    _softwareController.initializeCheckboxStates(_softwareController.relayList.value.length, false);
  }
}
