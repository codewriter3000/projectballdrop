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
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color(0xFF151515),
            body: SafeArea(
                    child: LayoutBuilder(
                      builder: (_, constraints) => GestureDetector(
                        onHorizontalDragDown: (hi){
                          print('local position: ${hi.localPosition}');
                          print('global position: ${hi.globalPosition}');
                        },
                        child: Container(
                          width: constraints.widthConstraints().maxWidth,
                          height: constraints.heightConstraints().maxHeight,
                          //color: Colors.blue,
                          child: CustomPaint(painter: LevelPainter()),
                        ),
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
        0.05,
        0.05,
        0.9,
        6,
        6);
    grid.draw();
    Ball b1 = new Ball(
      this,
      Colors.red,
      4,
      3,
      grid,
      'down');
    Obstacle o1 = new Obstacle(
      this,
      Colors.green,
      1,
      3,
      grid,
      3,
      false);
    Obstacle o2 = new Obstacle(
        this,
        Colors.brown,
        2,
        1,
        grid,
        2,
        true);
    Obstacle o3 = new Obstacle(
        this,
        Colors.teal,
        4,
        1,
        grid,
        3,
        true);
    Obstacle o4 = new Obstacle(
        this,
        Colors.orange,
        2,
        2,
        grid,
        2,
        false);
    Obstacle o5 = new Obstacle(
        this,
        Colors.yellow,
        6,
        2,
        grid,
        2,
        false);
    Obstacle o6 = new Obstacle(
        this,
        Colors.blue,
        3,
        4,
        grid,
        3,
        true);
    Obstacle o7 = new Obstacle(
        this,
        Colors.purple,
        1,
        6,
        grid,
        3,
        true);
    Goal g1 = new Goal(
      this,
      Colors.red,
      4,
      6,
      grid);
    o1.draw();
    o2.draw();
    o3.draw();
    o4.draw();
    o5.draw();
    o6.draw();
    o7.draw();
    b1.draw();
    g1.draw();
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
  double width; //width of each cell
  List<Offset> midPoints = List<Offset>.empty(growable: true); //scale decimals
  List<bool> tiles = List<bool>.empty(growable: true); //detects whether a field element exists on this square

  Grid(levelPainter, xUpperLeft, yUpperLeft, magnitude, rows, columns){
    this.levelPainter = levelPainter;
    this.xUpperLeft = xUpperLeft;
    this.yUpperLeft = yUpperLeft;
    this.magnitude = magnitude;
    this.rows = rows;
    this.columns = columns;
    if (levelPainter.canvasWidth < levelPainter.canvasHeight){
      xBottomRight = xUpperLeft + magnitude;
      //convert magnitude into pixels & apply magnitude in pixels to height
      yBottomRight = yUpperLeft + levelPainter.getDecimalFromHeight(levelPainter.getWidthFromDecimal(magnitude));
    } else {
      yBottomRight = yUpperLeft + magnitude;
      xBottomRight = xUpperLeft + levelPainter.getDecimalFromWidth(levelPainter.getHeightFromDecimal(magnitude));
    }
    for(int i = 1; i <= this.rows; i++){
      if(i == 1){
        width = levelPainter.getHeightFromDecimal(((yUpperLeft + (yBottomRight-yUpperLeft)*(i-1)/rows) + (yUpperLeft + (yBottomRight-yUpperLeft)*(i)/rows))/2);
      }
      for(int j = 1; j <= this.columns; j++){
        midPoints.add(new Offset(levelPainter.getWidthFromDecimal(((xUpperLeft + (xBottomRight-xUpperLeft)*(j-1)/columns) + (xUpperLeft + (xBottomRight-xUpperLeft)*(j)/columns))/2),
            levelPainter.getHeightFromDecimal(((yUpperLeft + (yBottomRight-yUpperLeft)*(i-1)/rows) + (yUpperLeft + (yBottomRight-yUpperLeft)*(i)/rows))/2)));
        tiles.add(false);
        //tiles[(rows*(i-1))+(j-1)] = false;
      }
    }
  }

  void draw(){
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white;
    levelPainter.canvas.drawRect( //TODO: puzzle isn't center-aligned
      Rect.fromPoints(new Offset(levelPainter.getWidthFromDecimal(xUpperLeft),
          levelPainter.getHeightFromDecimal(yUpperLeft)),
          new Offset(levelPainter.getWidthFromDecimal(xBottomRight),
          levelPainter.getHeightFromDecimal(yBottomRight))
    ), paint);
    for(int i = 1; i <= this.rows; i++){
      for(int j = 1; j <= this.columns; j++){
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

abstract class FieldElement {
  LevelPainter levelPainter;
  Color color; //color of the field element
  int initialX; //initial x-value
  int initialY; //initial y-value
  Grid grid; //grid that the field element is on

  void draw();
}

class Obstacle extends FieldElement{
  int length; //length of the obstacle
  bool horizontal; //true = horizontal, false = vertical
  int tempX; //temporary x-value
  int tempY; //temporary y-value
  int currX; //current x-value
  int currY; //current y-value
  Obstacle old; //old backup of obstacle

  Obstacle(LevelPainter levelPainter, Color color, int initialX, int initialY, Grid grid, int length, bool horizontal){
    this.levelPainter = levelPainter;
    this.color = color;
    this.initialX = initialX;
    this.initialY = initialY;
    this.grid = grid;
    this.length = length;
    this.horizontal = horizontal;
  }

  @override
  void draw() {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = color;
    final whitePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = Colors.white;
      if(this.horizontal == true){
        levelPainter.canvas.drawCircle(grid.midPoints[(grid.rows*(initialY-1))+(initialX-2+length)], 25, paint);
        levelPainter.canvas.drawRect(new Rect.fromPoints(new Offset(
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx,
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy - grid.width/2), new Offset(
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-2+length)].dx,
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy + grid.width/2)), paint);
        for(int i = 0; i < length; i++){
          grid.tiles[(grid.rows*(initialY-1))+(initialX-1)] = true;
        }
      } else {
        levelPainter.canvas.drawCircle(grid.midPoints[(grid.rows*(initialY-2+length))+(initialX-1)], 25, paint);
        levelPainter.canvas.drawRect(new Rect.fromPoints(new Offset(
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx - grid.width/2,
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), new Offset(
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx + grid.width/2,
            grid.midPoints[(grid.rows*(initialY-2+length))+(initialX-1)].dy)), paint);
        for(int i = 0; i < length; i++){
          grid.tiles[(grid.rows*(initialY-1))+(initialX-1)] = true;
        }
      }
      levelPainter.canvas.drawCircle(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)], 25, whitePaint);
  }
}

enum Direction {
  UP,
  DOWN,
  LEFT,
  RIGHT
}

class Ball extends FieldElement {
  int currX;
  int currY;
  Direction direction;

  Ball(LevelPainter levelPainter, Color color, int initialX, int initialY, Grid grid, String direction){
    this.levelPainter = levelPainter;
    this.color = color;
    this.initialX = initialX;
    this.initialY = initialY;
    this.grid = grid;
    switch(direction){
      case "up": this.direction = Direction.UP; break;
      case "down": this.direction = Direction.DOWN; break;
      case 'left': this.direction = Direction.LEFT; break;
      case 'right': this.direction = Direction.RIGHT; break;
    }
  }

  @override
  void draw() {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = color;
    final whitePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = Colors.white;
    levelPainter.canvas.drawCircle(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)], 25, paint);
    if(direction == Direction.DOWN){
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy + grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx - grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy + grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx + grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy + grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy - grid.width/3), whitePaint);
    } else if(direction == Direction.UP){
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy - grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx - grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy - grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx + grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy - grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy + grid.width/3), whitePaint);
    } else if(direction == Direction.LEFT){
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy - grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx - grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy + grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx - grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx - grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx + grid.width/3, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
    } else if(direction == Direction.RIGHT){
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy + grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx + grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy - grid.width/4), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx + grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
      levelPainter.canvas.drawLine(new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx - grid.width/3, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), new Offset(grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx + grid.width/4, grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), whitePaint);
    }
  }

  bool canMove(){
    //TODO
    return null;
  }
}

class Goal extends FieldElement {
  int currX;
  int currY;

  Goal(LevelPainter levelPainter, Color color, int initialX, int initialY, Grid grid){
    this.levelPainter = levelPainter;
    this.color = color;
    this.initialX = initialX;
    this.initialY = initialY;
    this.grid = grid;
  }

  @override
  void draw() {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = color;
    levelPainter.canvas.drawRect(new Rect.fromCircle(center: grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)], radius: 25), paint);
  }
}

/*FlatButton(
                                padding: EdgeInsets.only(left: 50, right: 50),
                                onPressed: () {
                                  print("Reset");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => GameView()),
                                  );
                                },
                                child: Card(
                                    margin: EdgeInsets.fromLTRB(25, 130, 25, 5),
                                    borderOnForeground: false,
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        "Reset Level",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontFamily: "Goldman"
                                        ),
                                      ),
                                    )
                                ),
                              ),*/