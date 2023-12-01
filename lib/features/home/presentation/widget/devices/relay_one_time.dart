import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/core/constants/dimens.dart';
import 'package:turkeysh_smart_home/core/constants/styles.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/features/home/presentation/widget/devices/take_time_part.dart';

import '../../../../../core/constants/images.dart';
import '../../../../../mqtt_service.dart';

class RelayOneTimeWidget extends StatelessWidget {
  RelayOneTimeWidget(
      {required this.title, required this.boardId, required this.nodeId,
        required this.onLongPress, Key? key})
      : super(key: key);

  String? title;
  int? boardId;
  int? nodeId;

  final _controller = Get.find<MqttService>();
  Function() onLongPress;
  var isPowerButtonExpanded = false.obs;
  var isDeviceSwitchOn = false.obs;
  var isPowerSwitchOn = false.obs;
  var isItemExpanded = false.obs;

  setRelaySwitchValue() {
    for (var element in _controller.relayDataList) {
      if (element.boardId == boardId) {
        switch (nodeId) {
          case 1:
            isPowerSwitchOn.value = element.key1 ?? false;
          case 2:
            isPowerSwitchOn.value = element.key2 ?? false;
          case 3:
            isPowerSwitchOn.value = element.key3 ?? false;
          case 4:
            isPowerSwitchOn.value = element.key4 ?? false;
          case 5:
            isPowerSwitchOn.value = element.key5 ?? false;
          case 6:
            isPowerSwitchOn.value = element.key6 ?? false;
          case 7:
            isPowerSwitchOn.value = element.key7 ?? false;
          case 8:
            isPowerSwitchOn.value = element.key8 ?? false;
          case 9:
            isPowerSwitchOn.value = element.key9 ?? false;
          case 10:
            isPowerSwitchOn.value = element.key10 ?? false;
          case 11:
            isPowerSwitchOn.value = element.key11 ?? false;
          case 12:
            isPowerSwitchOn.value = element.key12 ?? false;
        }
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              Images.right,
              width: MediaQuery
                  .sizeOf(context)
                  .width / 3,
              color: CustomColors.foregroundColor,
            ),
            const Text(
              'کلید تک تایمر',
              style: AppStyles.style1,
            ),
            SvgPicture.asset(
              Images.left,
              width: MediaQuery
                  .sizeOf(context)
                  .width / 3,
              color: CustomColors.foregroundColor,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onLongPress: onLongPress,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: MediaQuery
                .sizeOf(context)
                .width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 1),
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 4,
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
              image: const DecorationImage(
                  image: AssetImage(Images.logo),
                  fit: BoxFit.cover,
                  opacity: 0.05),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? '',
                      style: AppStyles.style9,
                    ),
                    GetBuilder<MqttService>(builder: (logic) {
                      setRelaySwitchValue();
                      return Switch(
                          value: isPowerSwitchOn.value,
                          activeColor:
                          CustomColors.backgroundColor,
                          activeTrackColor:
                          CustomColors.foregroundColor,
                          inactiveThumbColor: Colors.grey,
                          onChanged: (value) {
                            logic.update();
                            //isPowerSwitchOn.value = !isPowerSwitchOn.value;
                            String projectName = GetStorage().read(
                                AppUtils.projectNameConst);
                            String username = GetStorage().read(
                                AppUtils.username);
                            if (value) {
                              _controller.publishMessage(
                                  {
                                    'board_id': boardId,
                                    'node_id': nodeId,
                                    'status': true
                                  },
                                  '$projectName/$username/relay');
                            } else {
                              _controller.publishMessage(
                                  {
                                    'board_id': boardId,
                                    'node_id': nodeId,
                                    'status': false
                                  },
                                  '$projectName/$username/relay');
                            }
                          });
                    })
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  children: [
                    Obx(() {
                      return InkWell(
                          onTap: () {
                            isItemExpanded.value = !isItemExpanded.value;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('زمان های فعال'),
                                Icon(
                                  !isItemExpanded.value
                                      ? Icons.expand_more
                                      : Icons.expand_less,
                                  color: CustomColors.foregroundColor,
                                ),
                              ],
                            ),
                          ));
                    }),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                          () =>
                      isItemExpanded.value
                          ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Divider(
                              height: 0.5,
                              color: CustomColors.foregroundColor,
                            ),
                          ),
                          const TakeTimeWidget(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Divider(
                              height: 0.5,
                              color: CustomColors.foregroundColor,
                            ),
                          )
                        ],
                      )
                          : const SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Icon(
                        Icons.send,
                        color: CustomColors.foregroundColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Obx(() {
                      return InkWell(
                          onTap: () {
                            isPowerButtonExpanded.value =
                            !isPowerButtonExpanded.value;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('حذف زمان های تنظیم شده'),
                                Icon(
                                  !isPowerButtonExpanded.value
                                      ? Icons.expand_more
                                      : Icons.expand_less,
                                  color: CustomColors.foregroundColor,
                                ),
                              ],
                            ),
                          ));
                    }),
                    Obx(
                          () =>
                      isPowerButtonExpanded.value
                          ? Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Divider(
                            height: 0.5,
                            color: CustomColors.foregroundColor,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'حذف',
                                style: AppStyles.style7,
                              ),

                              Obx(() {
                                return Switch(
                                    value: isDeviceSwitchOn.value,
                                    activeColor: CustomColors.backgroundColor,
                                    activeTrackColor: CustomColors.foregroundColor,
                                    inactiveThumbColor: Colors.grey,
                                    onChanged: (value) {
                                      isDeviceSwitchOn.value = !isDeviceSwitchOn.value;
                                      // setState(() {
                                      //   isDeviceSwitchOn = !isDeviceSwitchOn;
                                      // });
                                    });
                              })


                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
