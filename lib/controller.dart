///Alex Micharski Updated 2 Jan 2021
///Micharski Technologies (c)2021 All Rights Reserved


//reads the gestures from the canvas and tells the view what to do
//(_grid.rows*(initialY-1))+(initialX-1)
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:d_ball/view.dart';
import 'package:flutter/cupertino.dart';

import 'main.dart';

class Controller extends ChangeNotifier {
  static final Controller _controller = Controller._internal();

  LevelPainter? _levelPainter;
  Offset? _startDrag;
  Offset? _currentPos;
  Grid? _grid;
  AudioCache _musicCache = AudioCache(prefix: "assets/");
  AudioPlayer _instance = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  factory Controller(){
    return _controller;
  }

  Controller._internal(){
    doNothing();
    //print("Controller is now implemented");
  }

  Offset? getStartDrag() { return _startDrag; }
  void setStartDrag(Offset startDrag) { this._startDrag = startDrag; }

  Offset? getCurrentPos() { return _currentPos; }
  void setCurrentPos(Offset currentPos){ this._currentPos = currentPos; }

  Grid? getGrid(){ return _grid; }
  void setGrid(Grid grid){ this._grid = grid; }

  LevelPainter? getLevelPainter(){ return _levelPainter; }
  void setLevelPainter(LevelPainter levelPainter){ this._levelPainter = levelPainter; }

  Offset getMouseCoords(){
    //returns the cell that the mouse is currently in
    double? dx, dy;
    for(int i = 0; i < _grid!.columns; i++){
      if(_grid!.midPoints[i].dx < _currentPos!.dx){ //_grid.midPoints[i].dx + _grid.width/2 < _currentPos.dx
        dx = i+2.0;
      }
    }
    if(dx == null){
      dx = 1;
    }
    for(int j = 0; j < _grid!.rows; j++){
      if(_grid!.midPoints[j*_grid!.rows].dy < _currentPos!.dy){ //_grid.midPoints[j*_grid.rows].dy + _grid.width/2 < _currentPos.dy
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
    double? dx, dy;
    for(int i = 0; i < _grid!.columns; i++){
      if(_grid!.midPoints[i].dx + _grid!.width/2 < point.dx){
        dx = i+2.0;
      }
    }
    if(dx == null){
      dx = 1;
    }
    for(int j = 0; j < _grid!.rows; j++){
      if(_grid!.midPoints[j*_grid!.rows].dy + _grid!.width/2 < point.dy){
        dy = j+2.0;
      }
    }
    if(dy == null){
      dy = 1;
    }
    return new Offset(dx, dy);
  }

  bool obstacleExists(Offset coords){
    try{
      if(_grid!.tiles[((coords.dy-1)*_grid!.rows + coords.dx).toInt() - 1] == true && !(coords.dx < 1 || coords.dy < 1 || coords.dx > _grid!.columns || coords.dy > _grid!.rows)){
        return true;
      } else if(coords.dx < 1 || coords.dy < 1 || coords.dx > _grid!.columns || coords.dy > _grid!.rows){
        return true;
      } else {
        return false;
      }
    } catch (RangeError) {
      return true;
    }
  }

  List<bool> obstacleBorders(Obstacle obstacle){
    //finds out the possible ways an obstacle can move
    //0 = top or left, 1 = bottom or right
    List<bool> tmp = List.filled(2, false, growable: false);
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

  Obstacle? findRoot(){
    //possible null exception because _levelPainter is instantiated in the LevelPainter and not in the event where move would be called
    //checks if the drag was started on an obstacle or on the ball
    //loop through every single obstacle and the cells they take up
    for(Obstacle obstacle in _levelPainter!.level.obstacles){
      //print('i cant fight this feeling anymore: $obstacle');
      for(int i = 0; i < obstacle.length; i++){
        //print("TIME FOR ME TO FLY:::::::::::::::::: ${getCoords(_startDrag) == Offset(obstacle.currX+i+0.0, obstacle.currY+0.0)}");
        if(obstacle.horizontal == true){
          //printCondition(getCoords(_startDrag), Offset(obstacle.currX+i+0.0, obstacle.currY+0.0));
          if(getCoords(_startDrag!) == Offset(obstacle.currX+i+0.0, obstacle.currY+0.0)){
            return obstacle;
          }
        } else {
          //printCondition(getCoords(_startDrag), Offset(obstacle.currX+0.0, obstacle.currY+i+0.0));
          if(getCoords(_startDrag!) == Offset(obstacle.currX+0.0, obstacle.currY+i+0.0)){
            return obstacle;
          }
        }
      }
    }
  }

  Future<void> playTick() async {
    //_instance = await _musicCache.play("tick.wav");
  }

  Future<void> playPowerUp() async {
    _instance = await _musicCache.play("powerup.wav");
    _instance.setVolume(0.5);
  }

  void moveObstacle() {
    //print('_startDrag: ${getCoords(_startDrag)}');
    //print('_currentPos: ${getCoords(_currentPos)}');
    //print("don't stop believin");
    //find the root of the obstacle you are moving
    //exit the void if you did not start your drag on an obstacle
    if(findRoot() == null){
      return;
    } else {
      //if the current mouse cell is different from the start drag cell, then start the move process
      Obstacle? root = findRoot();
      if(root!.horizontal){
        if((getCoords(_startDrag!).dx != getCoords(_currentPos!).dx) && verifyMove(getCoords(_startDrag!), getCoords(_currentPos!), root)){
          root.currX = (getCoords(_currentPos!).dx).toInt();
          //_startDrag = getCoords(_currentPos);
          playTick();
          _levelPainter!.changeNotifier.notifyListeners();
        }
      } else {
        if((getCoords(_startDrag!).dy != getCoords(_currentPos!).dy) && verifyMove(getCoords(_startDrag!), getCoords(_currentPos!), root)){
          root.currY = (getCoords(_currentPos!).dy).toInt();
          //_startDrag = getCoords(_currentPos);
          playTick();
          _levelPainter!.changeNotifier.notifyListeners();
        }
      }
    }
  }

  void tryBallMove(){
    final int currentLevel = _grid!.levelPainter.level.id;
    //print("ballX: ${_levelPainter.level.ball.currX}");
    //print("ballY: ${_levelPainter.level.ball.currY}");
    //print("goalX: ${_levelPainter.level.goal.initialX}");
    //print("goalY: ${_levelPainter.level.goal.initialY}");
    while(_levelPainter!.level.ball.currX != _levelPainter!.level.goal.initialX || _levelPainter!.level.ball.currY != _levelPainter!.level.goal.initialY){
      switch(_levelPainter!.level.ball.direction){
        case Direction.RIGHT:
          final num nullSafeIndex = ((_grid!.rows*(_levelPainter!.level.ball.currY-1))+(_levelPainter!.level.ball.currX));
          if(_grid!.tiles[nullSafeIndex.toInt()] == false){
            //print("ball is moved");
            playPowerUp();
            _levelPainter!.level.ball.currX += 1;
          } else {
            return;
          }
          break;
        case Direction.DOWN:
          final num nullSafeIndex = (_grid!.rows*(_levelPainter!.level.ball.currY))+(_levelPainter!.level.ball.currX-1);
          if(_grid!.tiles[nullSafeIndex.toInt()] == false){
            //print("ball is moved");
            playPowerUp();
            _levelPainter!.level.ball.currY += 1;
          } else {
            return;
          }
          break;
        case Direction.UP:
          final num nullSafeIndex = (_grid!.rows*(_levelPainter!.level.ball.currY-2))+(_levelPainter!.level.ball.currX-1);
          if(_grid!.tiles[nullSafeIndex.toInt()] == false){
            //print("ball is moved");
            playPowerUp();
            _levelPainter!.level.ball.currY -= 1;
          } else {
            return;
          }
          break;
        case Direction.LEFT:
          final num nullSafeIndex = (_grid!.rows*(_levelPainter!.level.ball.currY-1))+(_levelPainter!.level.ball.currX-2);
          if(_grid!.tiles[nullSafeIndex.toInt()] == false){
            //print("ball is moved");
            playPowerUp();
            _levelPainter!.level.ball.currX -= 1;
          } else {
            return;
          }
          break;
        default:
          throw Exception();
      }
    }
    //print("&&&&&&&&&&&&&&&");
    //print(GameView.lvl);
    //print(currentLevel);
    if(GameView.lvl == currentLevel){
      //print("LEVEL ${GameView.lvl} COMPLETE");
      GameView.lvl += 1;
      GameView.lvlComplete.value = true;
    }
  }

  //checks if the move is legal
  bool verifyMove(Offset old, Offset prime, Obstacle root){
    //print('old: $old');
    //print('root: ${Offset(root.currX+0.0, root.currY+0.0)}');
    //checks if you are clicking on the root
    if(old.dx != root.currX || old.dy != root.currY){
      return false;
    }
    //print('------------------------------------');
    //turn the entire obstacle tiles to false
    if(root.horizontal) {
      //for(int i = 0; i < root.length; i++){
        //_levelPainter.level._grid.tiles[(_levelPainter.level._grid.rows*(old.dy-1)).toInt()+(old.dx-1).toInt()] = false;
      //}
      if (prime.dx == 0.0 || prime.dx + root.length - 1 >= _grid!.columns + 1) {
        //print('obstacle is HORIZONTAL and being moved outside of _grid');
        return false;
      } else {
        if((prime.dx < old.dx && obstacleBorders(root)[0] == true) || (prime.dx+root.length-1 > old.dx+root.length-1 && obstacleBorders(root)[1] == true)){
          //print('obstacle is HORIZONTAL and being merged with an existing field element');
          return false;
        } else {
          return true;
        }
      }
    } else {
      if(prime.dy == 0.0 || prime.dy + root.length - 1 >= _grid!.rows + 1){
        //print('obstacle is VERTICAL and being moved outside of _grid');
        return false;
      } else {
        //print('obstacle is VERTICAL and being merged with an existing field element');
        if((prime.dy < old.dy && obstacleBorders(root)[0] == true) || (prime.dy+root.length-1 > old.dy+root.length-1 && obstacleBorders(root)[1] == true)){
          return false;
        } else {
          return true;
        }
      }
    }
    /*} else if(((!root.horizontal) && (prime.dy == 0.0 || prime.dy+root.length-1 >= 7.0)) || (root._grid.tiles[(_grid.rows*((prime.dy+root.length-1).toInt()-1))+((prime.dx).toInt()-1)] == true)){
      print(false);
      return false;
    } else {
      print(true);
      return true;
    }*/
  }

  void printStats(){
    if(_grid != null && _currentPos != null){
      print('_currentPos: $_currentPos');
    } else {
      if(_grid == null){
        print('_grid is null');
      }
      if (_currentPos == null){
        print('_currentPos is null');
      }
    }
  }

  void printCondition(var v1, var v2){
    print('$v1 == $v2');
  }
}