import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/controller/software_controller.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/resource/data_state.dart';
import '../../../../core/resource/connection/mqtt_service.dart';
import '../controller/hardware_scenario_controller.dart';

class SoftwareScenarioItem extends StatelessWidget {
  SoftwareScenarioItem({Key? key, required this.index, required this.onItemClicked}) : super(key: key);

  final int index;
  final Function() onItemClicked;
  final _softwareController = Get.find<SoftwareScenarioController>();
  final _mqttController = Get.find<MqttService>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return InkWell(
      onTap: onItemClicked,
      onLongPress: () {
        askDialog('حذف سناریو', 'آیا میخواهید سناریو را حذف کنید؟', () {
          Get.find<SoftwareScenarioController>()
              .deleteSoftwareScenario(
              Get.find<SoftwareScenarioController>()
                  .scenarioList[index]
                  .id!)
              .then((value) {

            _mqttController.publishMessage(
                {
                  'type': 'dell_software_scenario',
                  'scenario_id': Get.find<SoftwareScenarioController>()
                      .scenarioList[index]
                      .uniqueId!,
                },
                _softwareController.projectName +
                    '/' +
                    GetStorage().read(AppUtils.username) +
                    '/' +
                    'add_software_scenario');

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
          width: width > 600 ? width/2 : width,
          height: height / 12,
          margin: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 0),
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
            borderRadius: BorderRadius.circular(
                AppDimensions.borderRadius),
            image: const DecorationImage(
                image: AssetImage(Images.logo), fit: BoxFit.cover, opacity: 0.05),
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
