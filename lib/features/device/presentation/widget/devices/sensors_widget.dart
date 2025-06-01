import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_controller.dart';

import '../../../../../core/constants/dimens.dart';
import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/drop_box.dart';
import 'all_seneor_settings.dart';

class SensorWidget extends StatelessWidget {
  SensorWidget(
      {required this.title,
      required this.type,
      required this.boardId,
      required this.onLongPress,
      Key? key})
      : super(key: key);

  String? title;
  int? boardId;
  String? type;
  Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              Images.right,
              width: MediaQuery.sizeOf(context).width / 3,
              color: CustomColors.foregroundColor,
            ),
            Text(
              type == '1'
                  ? 'سنسور دما'
                  : type == '2'
                      ? 'سنسور سختی آب'
                      : type == '3'
                          ? 'سنسور PH'
                          : 'سنسور ',
              style: AppStyles.style1,
            ),
            SvgPicture.asset(
              Images.left,
              width: MediaQuery.sizeOf(context).width / 3,
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
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 0),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SfRadialGauge(
                    title: GaugeTitle(
                      text: title ?? '',
                    ),
                    axes: <RadialAxis>[
                      RadialAxis(
                          axisLabelStyle:
                              const GaugeTextStyle(fontFamily: 'IranSans'),
                          tickOffset: 30,
                          labelOffset: 30,
                          showAxisLine: false,
                          useRangeColorForAxis: true,
                          minimum: 0,
                          maximum: 1,
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 0,
                                endValue: 10,
                                color: Colors.green,
                                startWidth: 0,
                                endWidth: 10),
                            GaugeRange(
                                startValue: 0,
                                endValue: 10,
                                color: CustomColors.foregroundColor,
                                startWidth: 10,
                                endWidth: 20),
                            GaugeRange(
                                startValue: 10,
                                endValue: 10,
                                color: Colors.red,
                                startWidth: 20,
                                endWidth: 30)
                          ],
                          pointers: const <GaugePointer>[
                            NeedlePointer(value: 12)
                          ],
                          annotations: const <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Text(
                                  '123',
                                ),
                                angle: 90,
                                positionFactor: 0.5)
                          ])
                    ]),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Get.bottomSheet(Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                topLeft: Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text(
                                  'تنظیم سنسور',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                CustomDropDown(
                                  height:
                                      MediaQuery.sizeOf(context).height / 12,
                                  width: MediaQuery.sizeOf(context).width,
                                  items: const ['Max', 'Min'],
                                  title: 'نوع تنظیم',
                                  onPressed: (value) {
                                    if (value == 'Max') {
                                      Get.find<DeviceController>().isMax = true;
                                    } else {
                                      Get.find<DeviceController>().isMax =
                                          false;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 80,
                                  child: TextField(
                                    controller: Get.find<DeviceController>()
                                        .sensorConfigValue,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    // initialValue: value,
                                    decoration: InputDecoration(
                                      hintText: 'بازه ی سنسور',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color:
                                                CustomColors.foregroundColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomDropDown(
                                  height:
                                      MediaQuery.sizeOf(context).height / 12,
                                  width: MediaQuery.sizeOf(context).width,
                                  items: Get.find<DeviceController>()
                                      .deviceRelayName,
                                  title: 'کلیدها',
                                  onPressed: (value) {
                                    Get.find<DeviceController>().selectedRelayName = value;
                                    Get.find<DeviceController>()
                                            .selectedDeviceRelayBoard =
                                        Get.find<DeviceController>()
                                            .deviceRelayBoard[value];
                                    Get.find<DeviceController>()
                                            .selectedDeviceRelayNode =
                                        Get.find<DeviceController>()
                                            .deviceRelayNode[value];
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomDropDown(
                                  height:
                                  MediaQuery.sizeOf(context).height / 12,
                                  width: MediaQuery.sizeOf(context).width,
                                  items: const ['Off', 'On'],
                                  title: 'وضعیت',
                                  onPressed: (value) {
                                    Get.find<DeviceController>()
                                        .sensorConfigStatus = value == 'On';

                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  onClick: () {
                                    Get.find<DeviceController>().sendSensorConfigMessage(int.parse(type!), boardId!, title ?? '');
                                  },
                                ),
                                CustomButton(
                                  onClick: () {
                                    Get.find<DeviceController>().getSensorConfig();
                                    Get.to(AllSensorSettings(boardId: boardId!, type: int.parse(type!),));
                                  },
                                  buttonTitle: 'مشاهده تنظیمات گذشته',
                                ),
                                const SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('تنظیم سنسور'),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
