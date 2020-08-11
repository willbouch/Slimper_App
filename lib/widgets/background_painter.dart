import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var triangle1 = Paint();
    triangle1.color = Color(0xfff6f6f6);
    triangle1.style = PaintingStyle.fill;
    var triangle1Path = Path();
    triangle1Path.moveTo(0, size.height * 0.7);
    triangle1Path.lineTo(size.width * 0.6, 0);
    triangle1Path.lineTo(0, 0);
    canvas.drawPath(triangle1Path, triangle1);

    var triangle2 = Paint();
    triangle2.color = Color(0xffeaeaea);
    triangle2.style = PaintingStyle.fill;
    var triangle2Path = Path();
    triangle2Path.moveTo(0, size.height * 0.55);
    triangle2Path.lineTo(size.width * 0.45, 0);
    triangle2Path.lineTo(0, 0);
    canvas.drawPath(triangle2Path, triangle2);

    var triangle3 = Paint();
    triangle3.color = Color(0xffdddddd);
    triangle3.style = PaintingStyle.fill;
    var triangle3Path = Path();
    triangle3Path.moveTo(0, size.height * 0.4);
    triangle3Path.lineTo(size.width * 0.3, 0);
    triangle3Path.lineTo(0, 0);
    canvas.drawPath(triangle3Path, triangle3);

    var triangle4 = Paint();
    triangle4.color = Color(0xffd0d0d0);
    triangle4.style = PaintingStyle.fill;
    var triangle4Path = Path();
    triangle4Path.moveTo(0, size.height * 0.25);
    triangle4Path.lineTo(size.width * 0.15, 0);
    triangle4Path.lineTo(0, 0);
    canvas.drawPath(triangle4Path, triangle4);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
