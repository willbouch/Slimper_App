import 'package:flutter/material.dart';

import 'package:slimper/widgets/background_painter.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: CustomPaint(
        painter: BackgroundPainter(),
      ),
    );
  }
}
