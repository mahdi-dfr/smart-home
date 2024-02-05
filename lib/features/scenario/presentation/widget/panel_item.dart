import 'package:flutter/material.dart';
import 'package:turkeysh_smart_home/core/constants/styles.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';

class PanelItem extends StatelessWidget {
  PanelItem({required this.title, required this.onItemPressed, Key? key})
      : super(key: key);

  Function() onItemPressed;
  String title;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return InkWell(
      onTap: onItemPressed,
      child: Container(
        width: width,
        height: height / 12,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 0),
                spreadRadius: 1,
                blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          image: const DecorationImage(
              image: AssetImage(Images.logo), fit: BoxFit.cover, opacity: 0.05),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: AppStyles.style6,
          ),
        )
        )

    );
  }
}
