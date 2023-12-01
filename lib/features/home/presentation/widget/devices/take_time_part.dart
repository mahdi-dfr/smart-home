import 'package:flutter/material.dart';

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
                  createBottomSheet((hour, minute) {

                  }, (hour, minute) => null);
                },
                icon: Icon(Icons.timer, color: CustomColors.foregroundColor,)),
            IconButton(
                onPressed: () {},
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
