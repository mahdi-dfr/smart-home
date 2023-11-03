import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:turkeysh_smart_home/core/constants/dimens.dart';
import 'package:turkeysh_smart_home/core/constants/styles.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';

class ProjectItemWidget extends StatelessWidget {
  ProjectItemWidget(
      {required this.title,
      required this.onClick,
      required this.onLongClick,
      Key? key})
      : super(key: key);

  String title;
  Function() onClick;
  Function() onLongClick;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return InkWell(
      onTap: onClick,
      onLongPress: onLongClick,
      child: Container(
        width: width * 0.4,
        height: height / 5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        child: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(AppDimensions.smallPadding),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.logo),
                fit: BoxFit.cover,
                opacity: 0.05),
          ),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: CustomColors.foregroundColor),
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadius)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    Images.homeAnim,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    title,
                    style: AppStyles.style1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
