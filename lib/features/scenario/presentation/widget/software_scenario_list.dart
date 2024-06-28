import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/features/scenario/presentation/widget/software_scenario_item.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/resource/mqtt_service.dart';
import '../controller/software_controller.dart';

class SoftwareScenarioListWidget extends StatelessWidget {
  SoftwareScenarioListWidget({Key? key}) : super(key: key);

  final _softwareController = Get.find<SoftwareScenarioController>();
  final _mqttController = Get.find<MqttService>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Obx(() {
      return SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'لیست سناریو های نرم افزاری',
                        style: AppStyles.style6,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(PagesRoutes.chooseSoftwareScenario);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'افزودن',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.add)
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              _softwareController.scenarioList.value.isNotEmpty
                  ?  Expanded(
                child: SizedBox(
                  width: width > 600 ? width / 2 : width,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return SoftwareScenarioItem(
                        index: index,
                        onItemClicked: () {
                          askDialog('فعال کردن سناریو', 'آیا مطمئن هستید؟', () {
                            Get.back();
                            _mqttController.publishMessage(
                                {
                                  'type': 'run_software_scenario',
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
                  ),
                )

              ) : Lottie.asset(Images.empty, width: MediaQuery.sizeOf(context).width / 2)
            ],
          ));
    });
  }
}
