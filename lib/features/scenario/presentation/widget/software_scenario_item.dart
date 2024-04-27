import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/software_controller.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/resource/data_state.dart';
import '../controller/hardware_scenario_controller.dart';

class SoftwareScenarioItem extends StatelessWidget {
  SoftwareScenarioItem({Key? key, required this.index, required this.onItemClicked}) : super(key: key);

  final int index;
  final Function() onItemClicked;
  final _softwareController = Get.find<SoftwareScenarioController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return InkWell(
      onTap: onItemClicked,
      onLongPress: () {
        askDialog(() {
          Get.find<HardwareScenarioController>()
              .deleteHardwareScenario(
              Get.find<HardwareScenarioController>()
                  .scenarioList[index]
                  .id!)
              .then((value) {
            if (value is DataSuccess) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message: value.data ??
                      'اطلاعات با موفقیت حذف شد',
                ),
              );
            } else {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message:
                  value.error ?? 'خطا در ارسال اطلاعات',
                ),
              );
            }
          });
          Get.back();
        });
      },
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
                    color: _softwareController
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
                Text(_softwareController.scenarioList[index]
                    .name ??
                    'تعریف نشده')
              ],
            ),
          )),
    );
  }
}
