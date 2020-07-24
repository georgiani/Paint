import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ColorPoint {
  Offset offs;
  Color col;

  ColorPoint(this.offs, this.col);
}

class PaintModel extends Model {
  List<ColorPoint> _offsets = List<ColorPoint>();
  bool _menuOpen = false;
  Color _currentColor = Colors.black;
  AnimationController animContr;
  Animation openAnim;

  // Getters
  get offsets => _offsets;
  get menuOpen => _menuOpen;
  get currentColor => _currentColor;

  // Setters
  set currentColor(col) {
    _currentColor = col;
    notifyListeners();
  }

  void clearOffsets() {
    _offsets.clear();
    notifyListeners();
  }

  void addOffset(Offset off) {
    _offsets.add(ColorPoint(off, this.currentColor));
    notifyListeners();
  }

  void addGlobalToLocalOffset(off, context, details) {
    RenderBox drawingSpace = context.findRenderObject();
    // found the reference object for translating the point
    // from global to local
    Offset localPos = drawingSpace.globalToLocal(details.globalPosition);
    if (localPos.dy <= drawingSpace.size.height &&
        localPos.dy >= 0 &&
        localPos.dx <= drawingSpace.size.width &&
        localPos.dx >= 0) addOffset(localPos);
    notifyListeners();
  }

  void toggleMenu() {
    _menuOpen = !_menuOpen;
    notifyListeners();
  }
}

var paintModel = PaintModel();
