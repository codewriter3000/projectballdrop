import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import 'model.dart';

int lvl = 1;

class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  Level level;

  @override
  void initState() {
    level = new Level(lvl);
    level.execute().then((_) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color(0xFF151515),
            body: SafeArea(
                    child: LayoutBuilder(
                      builder: (_, constraints) => GestureDetector(
                        onHorizontalDragStart: (hi){
                          Controller controller = new Controller();
                          controller.startDrag = hi.localPosition;
                        },
                        onHorizontalDragUpdate: (hi){
                          Controller controller = new Controller();
                          controller.currentPos = hi.localPosition;
                          controller.moveObstacle();
                        },
                        onHorizontalDragEnd: (hi){
                          Controller controller = new Controller();
                          controller.startDrag = null;
                        },
                        child: Container( //TODO: fix the container so it doesn't take up the entire screen and center align the grid
                          width: constraints.widthConstraints().maxWidth,
                          height: constraints.heightConstraints().maxHeight,
                          //color: Colors.blue,
                          child: CustomPaint(
                              painter: LevelPainter(level),
                              child: Container(
                                margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 3/10, left: MediaQuery.of(context).size.width * 3/10, top: MediaQuery.of(context).size.height * 8.5/10),
                                child: FlatButton(
                                  //padding: EdgeInsets.only(left: 100, right: 100, top: 600),
                                  onPressed: () {
                                    print("Reset");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => GameView()),
                                    );
                                  },
                                  child: Card(
                                      //margin: EdgeInsets.fromLTRB(25, 30, 25, 5),
                                      borderOnForeground: false,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Text(
                                            "Reset Level",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontFamily: "Goldman"
                                            ),
                                          ),
                                        )
                                      )
                                  ),
                                ),
                              )//*/
                          ),
                        ),
                      ),
                    ),
                )
            )
        );
  }
}

class LevelPainter extends CustomPainter {
  Level level;
  double canvasHeight;
  double canvasWidth;
  Canvas canvas;

  LevelPainter(this.level);

  @override
  void paint(Canvas canvas, Size size) {
    final grid = level.grid;
    canvasHeight = size.width;
    canvasWidth = size.height;
    this.canvas = canvas;
    if (grid == null){
      print("grid is null");
      return;
    }
    grid.levelPainter = this;
    grid.draw();
    for (final obstacle in level.obstacles){
      print('for obstacle: $obstacle');
      obstacle.levelPainter = this;
      obstacle.draw();
    }
    for (final ball in level.ball){
      print('for ball: $ball');
      ball.levelPainter = this;
      ball.draw();
    }

    //TODO: parse json here
    //construct everything and draw them

    Controller controller = new Controller();
    controller.grid = grid;
    /*grid.printTiles();
    print(controller.obstacleBorders(o1));
    print(controller.obstacleBorders(o2));
    print(controller.obstacleBorders(o3));
    print(controller.obstacleBorders(o4));
    print(controller.obstacleBorders(o5));
    print(controller.obstacleBorders(o6));
    print(controller.obstacleBorders(o7));*/
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

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

  Grid(xUpperLeft, yUpperLeft, magnitude, rows, columns){
    this.xUpperLeft = xUpperLeft;
    this.yUpperLeft = yUpperLeft;
    this.magnitude = magnitude;
    this.rows = rows;
    this.columns = columns;
  }

  static Grid fromJson(dynamic data){
    return Grid(
      data['xUpperLeft'],
      data['yUpperLeft'],
      data['magnitude'],
      data['rows'],
      data['columns']
    );
  }

  void draw(){
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

  void printTiles(){
    List<bool> tmp = tiles;
    for(int i = 0; i < rows; i++){
      print(tmp.sublist(columns*i, ((i+1)*columns)));
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
  int id;
  int length; //length of the obstacle
  bool horizontal; //true = horizontal, false = vertical
  int tempX; //temporary x-value
  int tempY; //temporary y-value
  int currX; //current x-value
  int currY; //current y-value
  Obstacle old; //old backup of obstacle

  Obstacle(Color color, int initialX, int initialY, Grid grid, int length, bool horizontal){
    this.color = color;
    this.initialX = initialX;
    this.initialY = initialY;
    this.currX = initialX;
    this.currY = initialY;
    this.grid = grid;
    this.length = length;
    this.horizontal = horizontal;
  }

  static Obstacle fromJson(dynamic data){
    return Obstacle(
      data['color'],
      data['initialX'],
      data['initialY'],
      data['grid'],
      data['length'],
      data['horizontal']
    );
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
          grid.tiles[(grid.rows*(initialY-1))+(initialX-1+i)] = true;
        }
      } else {
        levelPainter.canvas.drawCircle(grid.midPoints[(grid.rows*(initialY-2+length))+(initialX-1)], 25, paint);
        levelPainter.canvas.drawRect(new Rect.fromPoints(new Offset(
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx - grid.width/2,
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dy), new Offset(
            grid.midPoints[(grid.rows*(initialY-1))+(initialX-1)].dx + grid.width/2,
            grid.midPoints[(grid.rows*(initialY-2+length))+(initialX-1)].dy)), paint);
        for(int i = 0; i < length; i++){
          grid.tiles[(grid.rows*(initialY-1+i))+(initialX-1)] = true;
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
  int id;
  int currX;
  int currY;
  Direction direction;

  Ball(Color color, int initialX, int initialY, Grid grid, String direction){
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

  static Ball fromJson(dynamic data){
    return Ball(
      data['color'],
      data['initialX'],
      data['initialY'],
      data['grid'],
      data['direction']
    );
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
    grid.tiles[(grid.rows*(initialY-1))+(initialX-1)] = true;
  }

  bool canMove(){
    //TODO
    return null;
  }
}

class Goal extends FieldElement {
  int id;
  int currX;
  int currY;

  Goal(Color color, int initialX, int initialY, Grid grid){
    this.color = color;
    this.initialX = initialX;
    this.initialY = initialY;
    this.grid = grid;
  }

  static Goal fromJson(dynamic data){
    return Goal(
      data['color'],
      data['initialX'],
      data['initialY'],
      data['grid']
    );
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