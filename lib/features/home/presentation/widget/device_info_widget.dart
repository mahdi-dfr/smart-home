import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/utils.dart';

class DeviceInfo extends StatelessWidget {
  DeviceInfo({required this.index, required this.width, Key? key}) : super(key: key);

  int index;
  double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            image: const DecorationImage(
                image: AssetImage(Images.logo),
                fit: BoxFit.cover,
                opacity: 0.05),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), offset: const Offset(0,0), spreadRadius: 1, blurRadius: 5 )
            ],
            color: Colors.white
        ),
        child: Column(
          children: [
            Align(alignment: Alignment.centerRight ,child: Text(AppUtils.deviceInfo.keys.toList()[index], style: AppStyles.style1,)),
            const SizedBox(height: 2,),
            Text(AppUtils.deviceInfo.values.toList()[index], style: AppStyles.style4,)
          ],
        ),
      ),
    );
  }
}
