import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PaintModel extends Model {
  int _paintMode = 0;

  get paintMode => _paintMode;
  set paintMode(int value) {
    _paintMode = value;
    notifyListeners();
  }
}

var paintModel = PaintModel();