import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final double strokeWidth;
  final double startAngle;
  final double sweepAngle;
  final Color color;

  MyPainter({
    this.startAngle,
    this.sweepAngle,
    this.strokeWidth,
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = color;

    double degToRad(double deg) => deg * (pi / 180.0);

    final path = Path()
      ..arcTo(
          Rect.fromCenter(
            center: Offset(size.height / 2, size.width / 2),
            height: size.height,
            width: size.width,
          ),
          degToRad(startAngle),
          degToRad(sweepAngle),
          false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SemiCircle extends StatelessWidget {
  final double diameter;
  final double startAngle;
  final double sweepAngle;
  final double strokeWidth;
  final Color color;

  const SemiCircle({
    @required this.diameter,
    @required this.startAngle,
    @required this.sweepAngle,
    @required this.strokeWidth,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        strokeWidth: strokeWidth,
        color: color,
      ),
      size: Size(diameter, diameter),
    );
  }
}
