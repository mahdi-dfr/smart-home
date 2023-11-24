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
                  createBottomSheet();
                },
                icon: const Icon(Icons.timer)),
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
