import 'package:flutter/material.dart';

import '../resource/custom_functions.dart';

class CustomToolbarShape extends CustomPainter {
  final Color lineColor;

  const CustomToolbarShape({required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
//First oval
    Rect pathGradientRect = Rect.fromCircle(
      center: Offset(size.width / 4, 0),
      radius: size.width / 1.4,
    );
    Gradient gradient = LinearGradient(
      colors: <Color>[
        const Color.fromRGBO(173, 0, 0, 1.0).withOpacity(1),
        const Color.fromRGBO(113, 29, 29, 1.0).withOpacity(1),
      ],
      stops: const [
        0.1,
        1.0,
      ],
    );
    paint.color = Colors.deepOrange;
    paint.shader = gradient.createShader(pathGradientRect);
    paint.strokeWidth = 2;
    Path path = CustomFunctions.getPathAppBar(size);
    canvas.drawPath(path, paint);
//Second oval
    //Second oval
    Rect secondOvalRect = Rect.fromPoints(
      Offset(-size.width / 2.5, -size.height),
      Offset(size.width * 1.4, size.height / 1.5),
    );
    gradient = LinearGradient(
      colors: <Color>[
        const Color.fromRGBO(225, 255, 255, 1).withOpacity(0.1),
        const Color.fromRGBO(170, 77, 5, 1.0).withOpacity(0.2),
      ],
      stops: const [
        0.0,
        1.0,
      ],
    );
    Paint secondOvalPaint = Paint()
      ..color = Colors.deepOrange
      ..shader = gradient.createShader(secondOvalRect);
    canvas.drawOval(secondOvalRect, secondOvalPaint);
//Third oval
    Rect thirdOvalRect = Rect.fromPoints(
      Offset(-size.width / 2.5, -size.height),
      Offset(size.width * 1.4, size.height / 2.7),
    );
    gradient = LinearGradient(
      colors: <Color>[
        const Color.fromRGBO(225, 255, 255, 1).withOpacity(0.05),
        const Color.fromRGBO(255, 196, 21, 1).withOpacity(0.2),
      ],
      stops: const [
        0.0,
        1.0,
      ],
    );
    Paint thirdOvalPaint = Paint()
      ..color = Colors.red
      ..shader = gradient.createShader(thirdOvalRect);
    canvas.drawOval(thirdOvalRect, thirdOvalPaint);
//Fourth oval
    Rect fourthOvalRect = CustomFunctions.getOvalRect(size);
    gradient = LinearGradient(
      colors: <Color>[
        Colors.red.withOpacity(0.9),
        const Color.fromRGBO(255, 0, 0, 1.0).withOpacity(0.3),
      ],
      stops: const [
        0.3,
        1.0,
      ],
    );
    Paint fourthOvalPaint = Paint()
      ..color = Colors.deepOrange
      ..shader = gradient.createShader(fourthOvalRect);
    canvas.drawOval(fourthOvalRect, fourthOvalPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
