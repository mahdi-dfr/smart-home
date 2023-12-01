import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/dimens.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/widget/custom_button.dart';

takeDateTimeDialog(BuildContext context, Function(String hour, String minute) onTimeClicked){
  var hour = ''.obs;
  var minute = ''.obs;
  return Get.defaultDialog(
      title: 'انتخاب زمان روشن',
      titleStyle: AppStyles.style9,
      content: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                AppDimensions.borderRadius),
            border: Border.all(
                color: CustomColors.foregroundColor,
                width: 0.5)),
        padding:
        const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Text(
                    hour.value == '' && minute.value ==''
                        ? 'انتخاب ساعت روشن'
                        : '$hour:$minute', style: AppStyles.style9,);
                }),
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(showPicker(
                        showSecondSelector: true,
                        context: context,
                        value: Time(
                            hour: 11,
                            minute: 30,
                            second: 20),
                        onChange: (Time newTime) {
                          onTimeClicked(
                              newTime.hour.toString(),
                              newTime.minute
                                  .toString());
                          hour.value = newTime.hour.toString();
                          minute.value = newTime.minute.toString();
                        },
                      ));
                    },
                    icon: Icon(
                      Icons.watch_later_outlined,
                      color: CustomColors
                          .foregroundColor,
                      size: 35,
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: CustomColors.foregroundColor,
              height: 0.5,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          'شنبه',
                          style: AppStyles.style8,
                        ),
                        RoundCheckBox(
                          onTap: (value) {},
                          size: 30,
                          checkedColor: CustomColors
                              .foregroundColor,
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          'یکشنبه',
                          style: AppStyles.style8,
                        ),
                        RoundCheckBox(
                          onTap: (value) {},
                          size: 30,
                          checkedColor: CustomColors
                              .foregroundColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          'دوشنبه',
                          style: AppStyles.style8,
                        ),
                        RoundCheckBox(
                          onTap: (value) {},
                          size: 30,
                          checkedColor: CustomColors
                              .foregroundColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          'سه شنبه',
                          style: AppStyles.style8,
                        ),
                        RoundCheckBox(
                          onTap: (value) {},
                          size: 30,
                          checkedColor: CustomColors
                              .foregroundColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          'چهارشنبه',
                          style: AppStyles.style8,
                        ),
                        RoundCheckBox(
                          onTap: (value) {},
                          size: 30,
                          checkedColor: CustomColors
                              .foregroundColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          'پنجشنبه',
                          style: AppStyles.style8,
                        ),
                        RoundCheckBox(
                          onTap: (value) {},
                          size: 30,
                          checkedColor: CustomColors
                              .foregroundColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        const Text(
                          'جمعه',
                          style: AppStyles.style8,
                        ),
                        RoundCheckBox(
                          onTap: (value) {},
                          size: 30,
                          checkedColor: CustomColors
                              .foregroundColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 72,
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(onClick: () {}),
          ],
        ),
      ));
}