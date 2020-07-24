import 'package:flutter/material.dart';
import 'paintModel.dart';

class PaintPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    for (int i = 0; i < paintModel.offsets.length - 1; i++) {
      if (paintModel.offsets[i].offs != null && paintModel.offsets[i + 1].offs != null) {
        Paint p1 = Paint()
        ..color = paintModel.offsets[i].col
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10.0;

        canvas.drawLine(paintModel.offsets[i].offs, paintModel.offsets[i + 1].offs, p1);
      }
    }
  }

  @override
  bool shouldRepaint(PaintPainter oldDelegate) => true;
}