import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/device_helper_controller.dart';
import 'package:turkeysh_smart_home/features/home/presentation/widget/devices/take_date_time_dialog.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/dimens.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/widget/custom_button.dart';

createBottomSheet(BuildContext context) {
  final _controller = Get.find<DeviceHelperController>();
  var width = MediaQuery.sizeOf(context).width;
  var height = MediaQuery.sizeOf(context).height;
  return Get.bottomSheet(
    BottomSheet(

        onClosing: () {},
        enableDrag: false,
        showDragHandle: true,
        builder: (context) {
          return Container(
            width: width,
            height: height / 2,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimensions.borderRadius),
                    topRight: Radius.circular(AppDimensions.borderRadius))),
            child: Container(
              height: height,
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: CustomColors.backgroundColor,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadius),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 1),
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 2)
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('زمان روشن'),
                            ElevatedButton(
                              onPressed: () {
                                takeDateTimeDialog(context, true);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.foregroundColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: const Text(
                                'انتخاب زمان',
                                style: AppStyles.style10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('زمان خاموش'),
                            ElevatedButton(
                              onPressed: () {
                                takeDateTimeDialog(context, false);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.foregroundColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: const Text(
                                'انتخاب زمان',
                                style: AppStyles.style10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),


                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        onClick: () {},
                        buttonTitle: 'ثبت',
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
    enableDrag: true,
    backgroundColor: Colors.white,
    elevation: 2,
  );
}
