import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/core/constants/dimens.dart';
import 'package:turkeysh_smart_home/core/constants/styles.dart';
import 'package:turkeysh_smart_home/features/device/presentation/widget/devices/take_time_part.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_helper_controller.dart';

import '../../../../../core/constants/images.dart';
import 'bottom_sheet.dart';

class RelayThreeTimeWidget extends StatefulWidget {
  RelayThreeTimeWidget({required this.title, Key? key}) : super(key: key);

  String? title;

  @override
  State<RelayThreeTimeWidget> createState() => _RelayThreeTimeWidgetState();
}

class _RelayThreeTimeWidgetState extends State<RelayThreeTimeWidget> {
  final _controller = Get.find<DeviceHelperController>();
  bool isItemExpanded = false;


  void setOnclickListener() {
    setState(() {
      isItemExpanded = !isItemExpanded;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Images.right,
              width: MediaQuery.sizeOf(context).width / 3,
              color: CustomColors.foregroundColor,
            ),
            const Text(
              'کلید سه تایمر',
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          width: MediaQuery.sizeOf(context).width,
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
                    widget.title ?? '',
                    style: AppStyles.style9,
                  ),
                  Obx(() {
                    return Switch(
                        value: _controller.isSwitchClicked.value,
                        activeColor: CustomColors.backgroundColor,
                        activeTrackColor: CustomColors.foregroundColor,
                        inactiveThumbColor: Colors.grey,
                        onChanged: (value) {
                          _controller.isSwitchClicked.value =
                              !_controller.isSwitchClicked.value;
                        });
                  }),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                  children: [
                    InkWell(
                        onTap: () {
                          setOnclickListener();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('زمان های فعال'),
                              Icon(
                                Icons.expand_more,
                                color: CustomColors.foregroundColor,
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    isItemExpanded
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
                              const TakeTimeWidget(),
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
                        horizontal: 52, vertical: 12),
                    child: Icon(
                      Icons.send,
                      color: CustomColors.foregroundColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

}
