//reads the gestures from the canvas and tells the view what to do
//(grid.rows*(initialY-1))+(initialX-1)
import 'dart:ui';

import 'package:d_ball/view.dart';

class Controller {
  static final Controller _controller = new Controller._internal();

  LevelPainter levelPainter;
  Offset startDrag;
  Offset currentPos;
  Grid grid;

  factory Controller(){
    return _controller;
  }

  Controller._internal(){
    print("Controller is now implemented");
  }

  Offset getMouseCoords(){
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

  //NOT FULLY TESTED YET
  Offset getCoords(Offset point){
    //returns the cell that the point is in
    double dx, dy;
    for(int i = 0; i < grid.columns; i++){
      if(grid.midPoints[i].dx + grid.width/2 < point.dx){
        dx = i+2.0;
      }
    }
    if(dx == null){
      dx = 1;
    }
    for(int j = 0; j < grid.rows; j++){
      if(grid.midPoints[j*grid.rows].dy + grid.width/2 < point.dy){
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
      //print('${obstacle.currX-1.0} ${obstacle.currY+0.0}');
      if(obstacleExists(new Offset(obstacle.currX-1.0, obstacle.currY+0.0))){
        tmp[0] = true;
      } else {
        tmp[0] = false;
      }
      //print('${obstacle.currX+obstacle.length+0.0} ${obstacle.currY+0.0}');
      if(obstacleExists(new Offset(obstacle.currX+obstacle.length+0.0, obstacle.currY+0.0))){
        tmp[1] = true;
      } else {
        tmp[1] = false;
      }
    } else {
      //print('${obstacle.currX+0.0} ${obstacle.currY-1.0}');
      if(obstacleExists(new Offset(obstacle.currX+0.0, obstacle.currY-1.0))){
        tmp[0] = true;
      } else {
        tmp[0] = false;
      }
      //print('${obstacle.currX+0.0} ${obstacle.currY+obstacle.length+0.0}');
      if(obstacleExists(new Offset(obstacle.currX+0.0, obstacle.currY+obstacle.length+0.0))){
        tmp[1] = true;
      } else {
        tmp[1] = false;
      }
    }
    return tmp;
  }

  Obstacle findRoot(){
    //possible null exception because levelPainter is instantiated in the LevelPainter and not in the event where move would be called
    //checks if the drag was started on an obstacle or on the ball
    //loop through every single obstacle and the cells they take up
    for(Obstacle obstacle in levelPainter.level.obstacles){
      for(int i = 0; i < obstacle.length; i++){
        if(obstacle.horizontal == true){
          //printCondition(getCoords(startDrag), Offset(obstacle.currX+i+0.0, obstacle.currY+0.0));
          if(getCoords(startDrag) == Offset(obstacle.currX+i+0.0, obstacle.currY+0.0)){
            return obstacle;
          }
        } else {
          //printCondition(getCoords(startDrag), Offset(obstacle.currX+0.0, obstacle.currY+i+0.0));
          if(getCoords(startDrag) == Offset(obstacle.currX+0.0, obstacle.currY+i+0.0)){
            return obstacle;
          }
        }
      }
    }
  }

  void moveObstacle(){
    //find the root of the obstacle you are moving
    //exit the void if you did not start your drag on an obstacle
    if(findRoot() == null){
      return;
    } else {
      //if the current mouse cell is different from the start drag cell, then start the move process
      Obstacle root = findRoot();
      if(root.horizontal){
        if(getCoords(startDrag).dx != getCoords(currentPos).dx){
          print('XXXXXXXXXXXXXXXXXXXXXXXXXXX');
          root.currX = (getCoords(currentPos).dx).toInt();
        }
      } else {
        if(getCoords(startDrag).dy != getCoords(currentPos).dy){
          print('YYYYYYYYYYYYYYYYYYYYYYYYYYY');
          root.currY = (getCoords(currentPos).dy).toInt();
        }
      }
    }
  }

  //checks if the move is legal
  bool verifyMove(Offset old, Offset prime){
    return true;
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

  void printCondition(var v1, var v2){
    print('$v1 == $v2');
  }
}