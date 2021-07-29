
import 'package:flutter/material.dart';

class BatteryLevelPainterWidget extends CustomPainter {
  final int batteryLevel;

  BatteryLevelPainterWidget({required this.batteryLevel});

  @override
  void paint(Canvas canvas, Size size) {
    Paint getPaint({Color color = Colors.black87, PaintingStyle style = PaintingStyle.stroke}) {
      return Paint()
        ..color = color
        ..strokeWidth = 1.0
        ..style = style;
    }

    final double batteryRight = size.width - 4.0;

    final RRect batteryOutline = RRect.fromLTRBR(0.0, 0.0, batteryRight, size.height, Radius.circular(3.0));

    // Battery body
    canvas.drawRRect(
      batteryOutline,
      getPaint(),
    );

    // Battery nub
    canvas.drawRect(
      Rect.fromLTWH(batteryRight, (size.height / 2.0) - 5.0, 4.0, 10.0),
      getPaint(style: PaintingStyle.fill),
    );

    // Fill rect
    canvas.clipRect(Rect.fromLTWH(0.0, 0.0, batteryRight * batteryLevel / 100.0, size.height));

    Color indicatorColor;
    if (batteryLevel < 20) {
      indicatorColor = Colors.red;
    } else if (batteryLevel < 50) {
      indicatorColor = Colors.orange;
    } else {
      indicatorColor = Colors.green;
    }

    canvas.drawRRect(RRect.fromLTRBR(0.5, 0.5, batteryRight - 0.5, size.height - 0.5, Radius.circular(3.0)),
        getPaint(style: PaintingStyle.fill, color: indicatorColor));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final old = oldDelegate as BatteryLevelPainterWidget;
    return old.batteryLevel != batteryLevel;
  }
}