import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFF151515),
            body: SafeArea(
                    child: LayoutBuilder(
                      builder: (_, constraints) => Container(
                          width: constraints.widthConstraints().maxWidth,
                          height: constraints.heightConstraints().maxHeight,
                          //color: Colors.blue,
                          child: CustomPaint(painter: LevelPainter())
                      ),
                    ),
                )
            )
        );
  }
}

class LevelPainter extends CustomPainter {
  double canvasHeight;
  double canvasWidth;
  Canvas canvas;
  @override
  void paint(Canvas canvas, Size size) {
    canvasHeight = size.width;
    canvasWidth = size.height;
    this.canvas = canvas;
    Grid grid = new Grid(
        this,
        0.1,
        0.1,
        0.8,
        6,
        6);
    grid.draw();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => null;

  double getHeightFromDecimal(double decimal){
    if (decimal.ceil() != 1){
      throw new ScaleDecimalOutOfRangeException(decimal);
    } else {
      return decimal * canvasHeight;
    }
  }

  double getWidthFromDecimal(double decimal){
    if (decimal.ceil() != 1){
      throw new ScaleDecimalOutOfRangeException(decimal);
    } else {
      return decimal * canvasWidth;
    }
  }

  double getDecimalFromHeight(double height){
    return height / canvasHeight;
  }

  double getDecimalFromWidth(double width){
    return width / canvasWidth;
  }
}

class ScaleDecimalOutOfRangeException implements Exception {
  String _message;

  ScaleDecimalOutOfRangeException(double decimal, [String message = 'Scale decimal is out of range: ']){
    this._message = message + '$decimal';
  }

  @override
  String toString(){
    return _message;
  }
}

class Grid {
  LevelPainter levelPainter;
  double xUpperLeft; //scale decimal
  double yUpperLeft; //scale decimal
  double magnitude; //scale decimal
  int rows; //quantity of rows
  int columns; //quantity of columns
  //needs to be filled manually by constructors
  double xBottomRight; //scale decimal
  double yBottomRight; //scale decimal
  double cellWidth; //scale decimal
  double cellHeight; //scale decimal
  List midPoints; //scale decimals

  Grid(levelPainter, xUpperLeft, yUpperLeft, magnitude, rows, columns){
    this.levelPainter = levelPainter;
    this.xUpperLeft = xUpperLeft;
    this.yUpperLeft = yUpperLeft;
    this.magnitude = magnitude;
    this.rows = rows;
    this.columns = columns;
    //print("width: ${levelPainter.canvasWidth}");
    //print("height: ${levelPainter.canvasHeight}");
    if (levelPainter.canvasWidth < levelPainter.canvasHeight){
      xBottomRight = xUpperLeft + magnitude;
      //print("xBottomRight: $xBottomRight");
      //convert magnitude into pixels & apply magnitude in pixels to height
      yBottomRight = yUpperLeft + levelPainter.getDecimalFromHeight(levelPainter.getWidthFromDecimal(magnitude));
      //TODO: cells
      for(int i = 1; i <= columns; i++){
        for(int j = 1; j <= rows; j++){

        }
      }
    } else if(levelPainter.canvasWidth == levelPainter.canvasHeight){

    } else {
      yBottomRight = yUpperLeft + magnitude;
      xBottomRight = xUpperLeft + levelPainter.getDecimalFromWidth(levelPainter.getHeightFromDecimal(magnitude));
      //print('xUpperLeft: $xUpperLeft');
      //print('magnitude: $magnitude');
      //print('xBottomRight: $xBottomRight');
      //print('yBottomRight: $yBottomRight');
    }
  }

  void draw(){
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white;
    levelPainter.canvas.drawRect( //TODO: puzzle isn't drawn perfectly to scale
      Rect.fromPoints(new Offset(levelPainter.getWidthFromDecimal(xUpperLeft),
          levelPainter.getHeightFromDecimal(yUpperLeft)),
          new Offset(levelPainter.getWidthFromDecimal(xBottomRight),
          levelPainter.getHeightFromDecimal(yBottomRight))
    ), paint);
    for(int i = 1; i < this.rows; i++){
      for(int j = 1; j < this.columns; j++){
        levelPainter.canvas.drawLine(new Offset(levelPainter.getWidthFromDecimal(xUpperLeft + (xBottomRight-xUpperLeft)*j/columns),
            levelPainter.getHeightFromDecimal(yUpperLeft)),
            new Offset(levelPainter.getWidthFromDecimal(xUpperLeft + (xBottomRight-xUpperLeft)*j/columns),
              levelPainter.getHeightFromDecimal(yBottomRight),
            ), paint);
        levelPainter.canvas.drawLine(new Offset(levelPainter.getWidthFromDecimal(xUpperLeft),
            levelPainter.getHeightFromDecimal(yUpperLeft + (yBottomRight-yUpperLeft)*i/rows)),
            new Offset(levelPainter.getWidthFromDecimal(xBottomRight),
              levelPainter.getHeightFromDecimal(yUpperLeft + (yBottomRight-yUpperLeft)*i/rows),
            ), paint);
      }
    }
  }
}