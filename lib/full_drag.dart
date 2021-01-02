import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:gestures/gestures.dart';

class FullDrag extends Gesture {
  MouseTracker mouseTracker;
  Offset initCoords;
  Offset currCoords;

  FullDrag({@required mouseTracker});

  bool _complete = false;
  @override
  bool get complete => _complete;

  bool _failed = false;
  @override
  bool get failed => _failed;

  @override
  void reset() {
    initCoords = null;
    currCoords = null;
  }

  bool _triggered = false;
  @override
  bool get triggered => _triggered;

  @override
  void update(Offset delta) {
    if(!_triggered){

    }
  }

}