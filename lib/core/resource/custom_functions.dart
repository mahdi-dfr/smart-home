import 'dart:ui';

class CustomFunctions{
  static Path getPathAppBar(Size size) {
    Path path = Path();
    path.lineTo(-size.width / 1.33, 0);
    path.quadraticBezierTo(
        size.width / 2, size.height * 2, size.width + size.width / 1.4, 0);
    path.close();
    return path;
  }

  static Rect getOvalRect(Size size) {
    Rect fourthOvalRect = Rect.fromPoints(
      Offset(-size.width / 2.4, -size.width / 1.875),
      Offset(size.width / 1.34, size.height / 1.14),
    );
    return fourthOvalRect;
  }
}