import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/images.dart';

class MyTurkeyshCard extends StatelessWidget {
  final Widget myWidget;
  final Widget? cornerLeftWidget;
  final Widget? cornerRightWidget;
  final double imageHeight;
  final double imageWidth;
  final double imageLeft;
  final double imageRight;

  const MyTurkeyshCard(
      {Key? key,
        required this.myWidget,
        this.imageHeight = 200,
        this.imageWidth = 200,
        this.imageLeft = -80,
        this.imageRight = -80,
        this.cornerLeftWidget,
        this.cornerRightWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(15),
                ) // green shaped
            ),
            child: cornerLeftWidget,
          ),
        ),
        Positioned(
          left:  imageLeft,
          right:  null,
          bottom: imageRight,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY( math.pi ),
            child: Container(
              height: imageHeight,
              width: imageWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.logo),
                    fit: BoxFit.cover,
                    opacity: 0.05),
              ),
            ),
          ),
        ),
        myWidget,
      ],
    );

  }
}
