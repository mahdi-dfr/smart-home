import 'package:flutter/material.dart';
import 'package:turkeysh_smart_home/core/constants/styles.dart';

Widget drawerItemList(
    {required Widget icon,
    required String title,
    required Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        icon,
        const SizedBox(width: 10,),
        Text(title, style: AppStyles.style4),
      ],
    ),
  );
}
