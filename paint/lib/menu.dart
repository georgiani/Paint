import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'paintModel.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    paintModel.animContr = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400,
      ),
    );

    // paintModel.openAnim =
    //     Tween<double>(begin: 0, end: 1).animate(paintModel.animContr);

    paintModel.openAnim = CurvedAnimation(
      curve: Curves.elasticInOut,
      parent: paintModel.animContr,
    );
  }

  @override
  void dispose() {
    paintModel.animContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PaintModel>(
      builder: (ctx, w, m) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ColorButton(Colors.red, -1, 0),
              ColorButton(Colors.blueAccent, 1, 0),
              ColorButton(Colors.greenAccent, -1, -1),
              ColorButton(Colors.black, 1, -1),
              IgnorePointer(
                child: Container(
                  color: Colors.transparent, // comment or change to transparent color
                  height: 150,
                  width: 150,
                ),
              ),
              Delete(),
              MenuOpen(),
            ],
          ),
        );
      },
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final int yDir;
  final int xDir;

  ColorButton(this.color, this.xDir, this.yDir);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: paintModel.openAnim,
      builder: (ctx, w) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(paintModel.openAnim.value * xDir * 70.0,
                paintModel.openAnim.value * yDir * 70.0),
          child: IconButton(
            icon: Icon(Icons.color_lens),
            color: color,
            enableFeedback: true,
            iconSize: 30,
            onPressed: () {
              paintModel.animContr.reverse();
              paintModel.toggleMenu();
              paintModel.currentColor = color;
            },
          ),
        );
      },
    );
  }
}

class Delete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: paintModel.openAnim,
      builder: (ctx, w) {
        return Transform.translate(
          offset: Offset(0, paintModel.openAnim.value * -70),
          child: IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.delete),
            color: Colors.redAccent,
            enableFeedback: true,
            iconSize: 30,
            onPressed: () {
              paintModel.animContr.reverse();
              paintModel.toggleMenu();
              paintModel.offsets.clear();
            },
          ),
        );
      },
    );
  }
}

class MenuOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        paintModel.menuOpen
            ? paintModel.animContr.reverse()
            : paintModel.animContr.forward();
        paintModel.toggleMenu();
      },
      child: Icon(Icons.menu),
    );
  }
}
