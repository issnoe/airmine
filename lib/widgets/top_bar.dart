import 'package:airmine/themes/colors.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 190.0,
      ),
      painter: CurvesPainter(),
    );
  }
}

class CurvesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(
      size.width * 0.22,
      size.height,
      size.width * 0.30,
      size.height * 0.40,
    );
    path.quadraticBezierTo(
      size.width * 0.40,
      size.height * 0.4,
      size.width * 0.50,
      size.height * 0.60,
    );
    path.quadraticBezierTo(
      size.width * 0.20,
      size.height * 0.87,
      size.width * 0.9,
      size.height * 0.78,
    );

    path.close();

    paint.color = thirdColor;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.20,
      size.height * 0.3,
      size.width * 0.27,
      size.height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.45,
      size.height,
      size.width * 0.50,
      size.height * 0.80,
    );
    path.quadraticBezierTo(
      size.width * 0.55,
      size.height * 0.45,
      size.width * 0.75,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.93,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(
      size.width,
      0,
    );
    path.close();

    paint.color = secondColor;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.10,
      size.height * 0.55,
      size.width * 0.20,
      size.height * 0.70,
    );
    path.quadraticBezierTo(
      size.width * 0.30,
      size.height * 0.90,
      size.width * 0.40,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.52,
      size.height * 0.50,
      size.width * 0.65,
      size.height * 0.70,
    );
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.85, size.width, size.height * 0.6);
    path.lineTo(
      size.width,
      0,
    );
    path.close();

    paint.color = firstColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
