import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paint/paintModel.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(PaintApp());
}

class PaintApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PaintAppMain(),
      ),
    );
  }
}

class PaintAppMain extends StatefulWidget {
  @override
  _PaintAppMainState createState() => _PaintAppMainState();
}

class _PaintAppMainState extends State<PaintAppMain> {
  final offsets = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox drawingSpace = context.findRenderObject();
              // found the reference object for translating the point
              // from global to local
              Offset localPos =
                  drawingSpace.globalToLocal(details.globalPosition);
              offsets.add(localPos);
            });
          },
          onPanEnd: (details) {
            offsets.add(null);
          },
          child: CustomPaint(
            painter: PaintPainter(offset: offsets),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          offsets.clear();
        },
        child: Icon(Icons.remove),
      ),
    );
  }
}

class PaintPainter extends CustomPainter {
  final offset;

  PaintPainter({this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < offset.length - 1; i++) {
      if (offset[i] != null && offset[i + 1] != null) {
        canvas.drawLine(offset[i], offset[i + 1], p);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
