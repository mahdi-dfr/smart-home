import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_controller.dart';

import '../../../../../core/constants/dimens.dart';
import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/resource/connection/board_connection_controller.dart';
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

  final _baseConnectionController = Get.find<BoardConnectionController>();
  final _controller = Get.find<DeviceController>();
  String sensorValue = '0';

  setSensorValue() {
    for (var element in _baseConnectionController.sensorDataList) {
      if (element.sensorId == boardId && element.dataType.toString() == type) {
        sensorValue = element.value!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
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
                      ? 'سنسور PH'
                      : type == '3'
                          ? 'سنسور سختی آب'
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
          height: 8,
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
                GetBuilder<BoardConnectionController>(
                  id: 'sensor',
                  builder: (logic) {
                    setSensorValue();
                    return SfRadialGauge(
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
                              maximum: type == '1'
                                  ? 100.0
                                  : type == '2'
                                      ? 14.0
                                      : type == '3'
                                          ? 5000.0
                                          : 10.0,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: type == '1'
                                        ? 100.0
                                        : type == '2'
                                            ? 14.0
                                            : type == '3'
                                                ? 5000.0
                                                : 10.0,
                                    color: CustomColors.foregroundColor,
                                    startWidth: 0,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 0,
                                    endValue: type == '1'
                                        ? 100.0
                                        : type == '2'
                                            ? 14.0
                                            : type == '3'
                                                ? 5000.0
                                                : 10.0,
                                    color: CustomColors.foregroundColor,
                                    startWidth: 10,
                                    endWidth: 20),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(value: double.parse(sensorValue))
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Text(
                                      sensorValue,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ])
                        ]);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _controller.isSensorConfigValidate.value = true;
                      _controller.sensorConfigValue.clear();
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
                                      _controller.isMax = true;
                                    } else {
                                      _controller.isMax = false;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Obx(() {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          controller:
                                              _controller.sensorConfigValue,
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          // initialValue: value,
                                          decoration: InputDecoration(
                                            hintText: 'بازه ی سنسور',
                                            hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: _controller
                                                        .isSensorConfigValidate
                                                        .value
                                                    ? 2
                                                    : 3,
                                                color: _controller
                                                        .isSensorConfigValidate
                                                        .value
                                                    ? Colors.black26
                                                    : Colors.red,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.black26),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        !_controller
                                                .isSensorConfigValidate.value
                                            ? const Text(
                                                'مقدار ورودی سنسور نامعتبر است',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14),
                                              )
                                            : const SizedBox(),
                                      ],
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomDropDown(
                                  height:
                                      MediaQuery.sizeOf(context).height / 12,
                                  width: MediaQuery.sizeOf(context).width,
                                  items: Get.find<DeviceController>()
                                      .deviceRelayName,
                                  title: 'کلیدها',
                                  onPressed: (value) {
                                    _controller.selectedRelayName = value;
                                    _controller.selectedDeviceRelayBoard =
                                        _controller.deviceRelayBoard[value];
                                    _controller.selectedDeviceRelayNode =
                                        _controller.deviceRelayNode[value];
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
                                    _controller.sendSensorConfigMessage(
                                        int.parse(type!),
                                        boardId!,
                                        title ?? '');
                                    ;
                                  },
                                ),
                                CustomButton(
                                  onClick: () {
                                    Get.find<DeviceController>()
                                        .getSensorConfig(type!);
                                    Get.to(AllSensorSettings(
                                      boardId: boardId!,
                                      type: int.parse(type!),
                                    ));
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
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
