import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/utils.dart';
import '../../../../mqtt_service.dart';
import '../../../home/presentation/controller/device_controller.dart';

class OneTimeWidget extends StatelessWidget {
  OneTimeWidget(
      {required this.title, required this.boardId, required this.nodeId, required this.onPressed, Key? key})
      : super(key: key);

  final _controller = Get.find<MqttService>();
  var isOneTimeButtonEnabled = false.obs;
  String? title;
  int? boardId;
  int? nodeId;
  Function() onPressed;

  late String projectName;
  late String username;

  setRelayOneTimeValue() {
    for (var element in _controller.relayDataList) {
      if (element.boardId == boardId) {
        switch (nodeId) {
          case 1:
            isOneTimeButtonEnabled.value = element.key1 ?? false;
          case 2:
            isOneTimeButtonEnabled.value = element.key2 ?? false;
          case 3:
            isOneTimeButtonEnabled.value = element.key3 ?? false;
          case 4:
            isOneTimeButtonEnabled.value = element.key4 ?? false;
          case 5:
            isOneTimeButtonEnabled.value = element.key5 ?? false;
          case 6:
            isOneTimeButtonEnabled.value = element.key6 ?? false;
          case 7:
            isOneTimeButtonEnabled.value = element.key7 ?? false;
          case 8:
            isOneTimeButtonEnabled.value = element.key8 ?? false;
          case 9:
            isOneTimeButtonEnabled.value = element.key9 ?? false;
          case 10:
            isOneTimeButtonEnabled.value = element.key10 ?? false;
          case 11:
            isOneTimeButtonEnabled.value = element.key11 ?? false;
          case 12:
            isOneTimeButtonEnabled.value = element.key12 ?? false;
        }
      }
    }

  }





  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          image: const DecorationImage(
              image: AssetImage(Images.logo),
              fit: BoxFit.cover,
              opacity: 0.05),
          borderRadius: BorderRadius.circular(
              AppDimensions.borderRadius),
          border: Border.all(
              color: CustomColors.foregroundColor,
              width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              flex: 2,
              child: GetBuilder<MqttService>(builder: (logic) {
                setRelayOneTimeValue();
                return IconButton(
                  onPressed: () {
                    logic.update();
                    projectName = GetStorage().read(
                        AppUtils.projectNameConst);
                    username = GetStorage().read(
                        AppUtils.username);

                    if (isOneTimeButtonEnabled.value) {
                      ///////////// _controller را به logic تغییر دادم:
                      logic.publishMessage(
                          {
                            'type':'relay',
                            'board_id': boardId,
                            'node_id': nodeId,
                            'node_status': true
                          },
                          '$projectName/$username/relay');
                    } else {
                      logic.publishMessage(
                          {
                            'type':'relay',
                            'board_id': boardId,
                            'node_id': nodeId,
                            'node_status': false
                          },
                          '$projectName/$username/relay');
                    }
                  },
                  icon: Icon(
                      Icons
                          .power_settings_new_rounded,
                      color: isOneTimeButtonEnabled
                          .value ? Colors.orange : CustomColors
                          .foregroundColor,
                      size: Get.width > 600
                          ? Get.width / 8
                          : Get.width / 6),
                );
              }),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8),
                child: Text(
                  title ??
                      '',
                  style:
                  const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),

      ),
    );

  }
}
