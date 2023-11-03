import 'package:flutter/material.dart';

class ImageRectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return getOvalRect(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

  static Rect getOvalRect(Size size) {
    Rect fourthOvalRect = Rect.fromPoints(
      Offset(-size.width / 2.4, -size.width / 1.875),
      Offset(size.width / 1.34, size.height / 1.14),
    );
    return fourthOvalRect;
  }
}


