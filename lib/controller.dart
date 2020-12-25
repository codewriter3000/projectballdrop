//reads the gestures from the canvas and tells the view what to do
//(grid.rows*(initialY-1))+(initialX-1)
import 'dart:ui';

import 'package:d_ball/view.dart';

class Controller {
  static final Controller _controller = new Controller._internal();

  Offset startDrag;
  Offset currentPos;
  Grid grid;

  factory Controller(){
    return _controller;
  }

  Controller._internal(){
    print("Controller is now implemented");
  }

  Offset getCoords(){
    //returns the cell that the mouse is currently in
    double dx, dy;
    for(int i = 0; i < grid.columns; i++){
      if(grid.midPoints[i].dx + grid.width/2 < currentPos.dx){
        dx = i+2.0;
      }
    }
    if(dx == null){
      dx = 1;
    }
    for(int j = 0; j < grid.rows; j++){
      if(grid.midPoints[j*grid.rows].dy + grid.width/2 < currentPos.dy){
        dy = j+2.0;
      }
    }
    if(dy == null){
      dy = 1;
    }
    return new Offset(dx, dy);
  }

  void printStats(){
    if(grid != null && currentPos != null){
      print('currentPos: $currentPos');
    } else {
      if(grid == null){
        print('grid is null');
      }
      if (currentPos == null){
        print('currentPos is null');
      }
    }
  }
}