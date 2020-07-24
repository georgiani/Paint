import 'package:flutter/material.dart';
import 'package:paint/menu.dart';
import 'package:paint/paintModel.dart';
import 'package:paint/paintPainter.dart';
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

class PaintAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<PaintModel>(
      model: paintModel,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DrawingArea(),
                  ),
                ),
                Menu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawingArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PaintModel>(
      builder: (ctx, w, m) {
        return GestureDetector(
          onPanUpdate: (details) => paintModel.addGlobalToLocalOffset(
              details.globalPosition, context, details),
          onPanEnd: (details) {
            paintModel.addOffset(null);
          },
          child: CustomPaint(
            foregroundPainter: PaintPainter(),
            child: Material(
              elevation: 20,
              shadowColor: Colors.blueAccent,
              child: Container(),
              shape: ContinuousRectangleBorder(),
            ),
          ),
        );
      },
    );
  }
}
