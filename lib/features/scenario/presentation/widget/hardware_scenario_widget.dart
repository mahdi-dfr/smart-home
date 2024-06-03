import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/constants/app_constant_data.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/resource/data_state.dart';
import '../../../../mqtt_service.dart';
import '../controller/hardware_scenario_controller.dart';
import 'hardware_pannel_item.dart';

class HardwareScenarioWidget extends StatelessWidget {
  HardwareScenarioWidget({
    Key? key,
  }) : super(key: key);

  final _controller = Get.find<HardwareScenarioController>();
  final _mqttController = Get.find<MqttService>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Container(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      height: height * 0.45,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), border: Border.all(width: 2, color: CustomColors.foregroundColor)),
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
                      _controller.changePanelType((pannelScenarioNumberList[index]).toString());
                      Get.toNamed(PagesRoutes.chooseHardwareScenario);
                    },
                    onLongClick: () {
                      askDialog('حذف سناریو', 'آیا میخواهید سناریو را حذف کنید؟', () {
                        _controller.deleteHardwareScenario((pannelScenarioNumberList[index]).toString()).then((value) {
                          if (value is DataSuccess) {

                            _mqttController.publishMessage(
                                {
                                  'type': 'dell_hardware_scenario',
                                  'key_num': pannelScenarioNumberList[index],
                                },
                                _controller.projectName +
                                    '/' +
                                    GetStorage().read(AppUtils.username) +
                                    '/' +
                                    'add_hardware_scenario');

                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.success(
                                message: value.data ?? 'اطلاعات با موفقیت حذف شد',
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
                        Get.back();
                      });
                    },
                  );
                },
                itemCount: 4)
          ],
        ),
      ),
    );
  }
}
