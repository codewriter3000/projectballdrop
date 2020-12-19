import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:box2d_flame/box2d_browser.dart';

class Grid {
  int x;
  int y;
  int dimensions;
  int rows;
  int columns;
  int _scaleX;
  int _scaleY;
  int _xPixels;
  int _yPixels;
  int _topLeft;
  int _topRight;
  int _bottomLeft;
  int _bottomRight;
  int _xCell;
  int _yCell;

  Grid({x, y, dimensions, rows, columns}){

  }
}