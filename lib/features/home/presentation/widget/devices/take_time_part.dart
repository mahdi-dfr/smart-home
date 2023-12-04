import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/device_helper_controller.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/styles.dart';
import 'bottom_sheet.dart';

class TakeTimeWidget extends StatelessWidget {
  const TakeTimeWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'زمانی انتخاب نشده است',
          style: AppStyles.style4,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  createBottomSheet(context);
                },
                icon: Icon(Icons.timer, color: CustomColors.foregroundColor,)),
            IconButton(
                onPressed: () {
                  Get.find<DeviceHelperController>().removeAllTimes();
                },
                icon: Icon(
                  Icons.delete,
                  color: CustomColors.foregroundColor,
                )),
          ],
        )
      ],
    );
  }
}
