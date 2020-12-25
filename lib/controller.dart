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

  bool obstacleExists(Offset coords){
    if(grid.tiles[((coords.dy-1)*grid.rows + coords.dx).toInt() - 1] == true && !(coords.dx < 1 || coords.dy < 1 || coords.dx > grid.columns || coords.dy > grid.rows)){
      return true;
    } else if(coords.dx < 1 || coords.dy < 1 || coords.dx > grid.columns || coords.dy > grid.rows){
      return true;
    } else {
      return false;
    }
  }

  List<bool> obstacleBorders(Obstacle obstacle){
    //finds out the possible ways an obstacle can move
    //0 = top or left, 1 = bottom or right
    List<bool> tmp = new List(2);
    if(obstacle.horizontal){
      print('${obstacle.currX-1.0} ${obstacle.currY+0.0}');
      if(obstacleExists(new Offset(obstacle.currX-1.0, obstacle.currY+0.0))){
        tmp[0] = true;
      } else {
        tmp[0] = false;
      }
      print('${obstacle.currX+obstacle.length+0.0} ${obstacle.currY+0.0}');
      if(obstacleExists(new Offset(obstacle.currX+obstacle.length+0.0, obstacle.currY+0.0))){
        tmp[1] = true;
      } else {
        tmp[1] = false;
      }
    } else {
      print('${obstacle.currX+0.0} ${obstacle.currY-1.0}');
      if(obstacleExists(new Offset(obstacle.currX+0.0, obstacle.currY-1.0))){
        tmp[0] = true;
      } else {
        tmp[0] = false;
      }
      print('${obstacle.currX+0.0} ${obstacle.currY+obstacle.length+0.0}');
      if(obstacleExists(new Offset(obstacle.currX+0.0, obstacle.currY+obstacle.length+0.0))){
        tmp[1] = true;
      } else {
        tmp[1] = false;
      }
    }
    return tmp;
  }

  Obstacle findObstacle(){

  }

  void moveObstacle(){

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