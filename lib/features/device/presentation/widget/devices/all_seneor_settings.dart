import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/resource/ask_dialog.dart';
import 'package:turkeysh_smart_home/core/widget/custom_button.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_controller.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/widget/custom_app_bar.dart';

class AllSensorSettings extends StatelessWidget {
  AllSensorSettings({super.key, required this.boardId, required this.type});

  final int boardId;
  final int type;

  final _controller = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: 150,
        titleWidget: const Text(
          'تنظیمات سنسورها',
          style: AppStyles.appbarTitleStyle,
        ),
      ),
      body: SafeArea(
          child: Stack(children: [
        Obx(() {
          return _controller.configList.isEmpty
              ? Center(
                  child: Lottie.asset(Images.empty,
                      width: MediaQuery.sizeOf(context).width / 2),
                )
              : ListView.separated(
            padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                            image: AssetImage(Images.logo),
                            fit: BoxFit.cover,
                            opacity: 0.05),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'نام سنسور:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    _controller.configList[index].sensorName!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'بازه ی سنسور:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    _controller.configList[index].configRange
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'وضعیت کلید:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    _controller.configList[index].status!
                                        ? 'روشن'
                                        : 'خاموش',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'نوع سنسور:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    _controller.configList[index].configType! ==
                                            '1'
                                        ? 'سنسور دما'
                                        : _controller.configList[index]
                                                    .configType! ==
                                                '2'
                                            ? 'سنسور PH'
                                            : 'سنسور سختی آب',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'نام کلید:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    _controller.configList[index].keyName!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4,),
                              Row(
                                children: [
                                  const Text(
                                    'نوع تنظیم:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    _controller.configList[index].maxOrMin!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: _controller.configList.length);
        }),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Obx(() {
            return _controller.configList.isNotEmpty
                ? CustomButton(
                    onClick: () {
                      if (_controller.configList.isNotEmpty) {
                        askDialog('حذف همه تنظیمات', 'آیا مطمئن هستید؟', () {
                          _controller.deleteAllConfigs(type, boardId);
                          Get.back();
                        });
                      } else {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                            message: 'آبتمی برای حذف وجود ندارد!',
                          ),
                        );
                      }
                    },
                    buttonTitle: 'حذف همه تنظیمات',
                  )
                : const SizedBox();
          }),
        ),
      ])),
    );
  }
}
