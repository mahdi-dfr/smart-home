import 'package:flutter/material.dart';

import '../../../../core/constants/app_constant_data.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/styles.dart';

class HardwarePannelItem extends StatelessWidget {
  const HardwarePannelItem({Key? key, required this.title, required this.onClick, required this.onLongClick}) : super(key: key);

  final String title;
  final Function() onClick;
  final Function() onLongClick;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onLongPress: onLongClick,
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(Images.logo),
                  fit: BoxFit.cover,
                  opacity: 0.05),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white),
          child: Center(
            child: Text(title, style: AppStyles.style11,),
          ),
        ),
      ),
    );
  }
}
