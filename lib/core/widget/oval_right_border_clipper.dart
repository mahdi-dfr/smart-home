import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvalRightBorderClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    //debugPrint('isLtr+++++:' + controller.isLtr.toString());
    path.moveTo(size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(50, 0);
    path.quadraticBezierTo(0, size.height / 4, 0, size.height / 2);
    path.quadraticBezierTo(
        0, size.height - (size.height / 4), 40, size.height);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
