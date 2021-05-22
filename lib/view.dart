///Alex Micharski Updated 2 Jan 2021
///Micharski Technologies (c)2021 All Rights Reserved

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestures/gestures.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'ad_manager.dart';
import 'controller.dart';
import 'full_drag.dart';
import 'main.dart';
import 'model.dart';
import 'level_generator.dart';

final changeNotifier = ChangeNotifier();

class GameView extends StatefulWidget {
  static int lvl = 0;
  static ValueNotifier<bool> lvlComplete = ValueNotifier(false);
  static int lvlQuantity = 16;

  static _GameViewState of(BuildContext context) =>
      context.findAncestorStateOfType<_GameViewState>();

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  Level level;
  BannerAd _bannerAd;

  Future<void> _initAdMob() => FirebaseAdMob.instance.initialize(appId: AdManager.appId);

  void _loadBannerAd(){
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.top);
  }

  @override
  void initState() {
    level = new Level(GameView.lvl);
    level.execute().then((_) => setState(() {}));
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();
  }

  @override
  void dispose(){
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF151515),
        body: SafeArea(
          child: ValueListenableBuilder<bool>(
            valueListenable: GameView.lvlComplete,
            builder: (BuildContext context, bool lvlComplete, Widget child){
              return LayoutBuilder(
                builder: (_, constraints) => GestureDetector(
                  onPanStart: (hi) {
                    Controller controller = new Controller();
                    controller.startDrag = hi.localPosition;
                  },
                  onPanUpdate: (hi) {
                    Controller controller = new Controller();
                    controller.currentPos = hi.localPosition;
                    controller.moveObstacle();
                    controller.startDrag = hi.localPosition;
                  },
                  onPanEnd: (hi) {
                    Controller controller = new Controller();
                    controller.tryBallMove();
                    controller.levelPainter.changeNotifier.notifyListeners();
                    controller.startDrag = null;
                    controller.currentPos = null;
                  },
                  child: Container(
                    width: constraints.widthConstraints().maxWidth,
                    height: constraints.heightConstraints().maxHeight,
                    child: Container(
                      child: CustomPaint(
                        painter: LevelPainter(level, changeNotifier),
                        child: Column(
                          children: <Widget>[
                            Text(
                              GameView.lvlQuantity >= GameView.lvl ? GameView.lvlComplete.value == false ? "Level ${GameView.lvl}" : "Level Complete" : "Game Complete",
                              style: TextStyle(
                                fontFamily: "Goldman",
                                //fontWeight: FontWeight.bold,
                                fontSize: GameView.lvlComplete.value == false ? 60 : 50,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            Container(
                              //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 3/10, left: MediaQuery.of(context).size.width * 3/10, top: MediaQuery.of(context).size.height * 8.5/10),
                              child: FlatButton(
                                //padding: EdgeInsets.only(left: 100, right: 100, top: 600),
                                onPressed: () {
                                  print(
                                      "###############################################");
                                  print(
                                      "###############################################");
                                  print(
                                      "###############################################");
                                  if(GameView.lvl > 100){
                                    var customLvl = new LevelFactory();
                                    customLvl.createLevel();
                                  }
                                  if (GameView.lvlQuantity < GameView.lvl){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DBall()),
                                    );
                                    return;
                                  }
                                  level = null;
                                  GameView.lvlComplete = ValueNotifier(false);
                                  initState();
                                },
                                child: Card(
                                  //margin: EdgeInsets.fromLTRB(25, 30, 25, 5),
                                  borderOnForeground: false,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        GameView.lvlQuantity >= GameView.lvl ? GameView.lvlComplete.value == false ? "Reset Level" : "Next Level" : "Celebrate",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 30, fontFamily: "Goldman"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LevelPainter extends CustomPainter {
  Level level;
  double canvasHeight;
  double canvasWidth;
  Canvas canvas;
  ChangeNotifier changeNotifier;

  LevelPainter(this.level, Listenable repaint) : super(repaint: repaint) {
    changeNotifier = repaint;
  }


  @override
  void paint(Canvas canvas, Size size) {
    var grid = level.grid;
    canvasHeight = size.width;
    canvasWidth = size.height;
    this.canvas = canvas;
    if (grid == null) {
      print("grid is null");
      return;
    }
    grid.levelPainter = this;
    grid.draw();
    final goal = level.goal;
    goal.grid = grid;
    goal.levelPainter = this;
    goal.draw();
    for (final obstacle in level.obstacles) {
      obstacle.grid = grid;
      obstacle.levelPainter = this;
      obstacle.draw();
    }
    final ball = level.ball;
    ball.grid = grid;
    ball.levelPainter = this;
    ball.draw();

    Controller controller = new Controller();
    controller.grid = grid;
    controller.levelPainter = this;
    print("Controller finished implementation");
    /*for(double i = this.getWidthFromDecimal(grid.xUpperLeft); i <= this.getWidthFromDecimal(grid.xBottomRight); i++){
      for(double j = this.getHeightFromDecimal(grid.yUpperLeft); j <= this.getHeightFromDecimal(grid.yBottomRight); j++){
        print(controller.getCoords(Offset(i, j)));
      }
    }*/
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  static Color hexToColor(String code) {
    return new Color(int.parse(code));
  }

  double getHeightFromDecimal(double decimal) {
    if (decimal.ceil() != 1) {
      throw new ScaleDecimalOutOfRangeException(decimal);
    } else {
      return decimal * canvasHeight;
    }
  }

  double getWidthFromDecimal(double decimal) {
    if (decimal.ceil() != 1) {
      throw new ScaleDecimalOutOfRangeException(decimal);
    } else {
      return decimal * canvasWidth;
    }
  }

  double getDecimalFromHeight(double height) {
    return height / canvasHeight;
  }

  double getDecimalFromWidth(double width) {
    return width / canvasWidth;
  }
}

class ScaleDecimalOutOfRangeException implements Exception {
  String _message;

  ScaleDecimalOutOfRangeException(double decimal,
      [String message = 'Scale decimal is out of range: ']) {
    this._message = message + '$decimal';
  }

  @override
  String toString() {
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
  List<bool> tiles = List<bool>.empty(
      growable: true); //detects whether a field element exists on this square

  Grid(xUpperLeft, yUpperLeft, magnitude, rows, columns) {
    this.xUpperLeft = xUpperLeft;
    this.yUpperLeft = yUpperLeft;
    this.magnitude = magnitude;
    this.rows = rows;
    this.columns = columns;
  }

  static Grid fromJson(dynamic data) {
    return Grid(data['xUpperLeft'], data['yUpperLeft'], data['magnitude'],
        data['rows'], data['columns']);
  }

  String toString() {
    return 'levelPainter: $levelPainter\n'
        'xUpperLeft: $xUpperLeft\n'
        'yUpperLeft: $yUpperLeft\n'
        'magnitude: $magnitude\n'
        'rows: $rows\n'
        'columns: $columns\n'
        'xBottomRight: $xBottomRight\n'
        'yBottomRight: $yBottomRight\n'
        'cellWidth: $cellWidth\n'
        'cellHeight: $cellHeight\n'
        'width: $width\n'
        'midPoints: $midPoints\n'
        'tiles: $tiles\n';
  }

  void setMidpoints() {
    if (levelPainter.canvasWidth < levelPainter.canvasHeight) {
      xBottomRight = xUpperLeft + magnitude;
      //convert magnitude into pixels & apply magnitude in pixels to height
      yBottomRight = yUpperLeft +
          levelPainter.getDecimalFromHeight(
              levelPainter.getWidthFromDecimal(magnitude));
    } else {
      xBottomRight = xUpperLeft +
          levelPainter.getDecimalFromWidth(
              levelPainter.getHeightFromDecimal(magnitude));
      yBottomRight = yUpperLeft + magnitude;
    }
    for (int i = 1; i <= this.rows; i++) {
      for (int j = 1; j <= this.columns; j++) {
        /*
        print('first part: ${xUpperLeft + (xBottomRight-xUpperLeft)*(j-1)/columns}');
        print('2nd part: ${(xBottomRight-xUpperLeft)*(j-1)/columns}');
        print('3rd part: $columns');
        print('4th part: ${(xBottomRight-xUpperLeft)*(j-1)}');
        print('5th part: ${(xBottomRight-xUpperLeft)}');
        print('6th part: ${j-1}');*/
        midPoints.add(new Offset(
            levelPainter.getWidthFromDecimal(((xUpperLeft +
                        (xBottomRight - xUpperLeft) * (j - 1) / columns) +
                    (xUpperLeft +
                        (xBottomRight - xUpperLeft) * (j) / columns)) /
                2),
            levelPainter.getHeightFromDecimal(((yUpperLeft +
                        (yBottomRight - yUpperLeft) * (i - 1) / rows) +
                    (yUpperLeft + (yBottomRight - yUpperLeft) * (i) / rows)) /
                2)));
        tiles.add(false);
        //tiles[(rows*(i-1))+(j-1)] = false;
      }
      if (i == 1) {
        width = levelPainter.getHeightFromDecimal(
            ((yUpperLeft + (yBottomRight - yUpperLeft) * (i - 1) / rows) +
                    (yUpperLeft + (yBottomRight - yUpperLeft) * (i) / rows)) /
                2);
        width = midPoints[1].dx - midPoints[0].dx;
      }
    }
  }

  /*void matchBallAndGoal(){
    for(Ball b in levelPainter.level.ball){

    }
  }*/

  void draw() {
    setMidpoints();
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white;
    levelPainter.canvas.drawRect(
        //TODO: puzzle isn't center-aligned
        Rect.fromPoints(
            new Offset(levelPainter.getWidthFromDecimal(xUpperLeft),
                levelPainter.getHeightFromDecimal(yUpperLeft)),
            new Offset(levelPainter.getWidthFromDecimal(xBottomRight),
                levelPainter.getHeightFromDecimal(yBottomRight))),
        paint);
    for (int i = 1; i <= this.rows; i++) {
      for (int j = 1; j <= this.columns; j++) {
        levelPainter.canvas.drawLine(
            new Offset(
                levelPainter.getWidthFromDecimal(
                    xUpperLeft + (xBottomRight - xUpperLeft) * j / columns),
                levelPainter.getHeightFromDecimal(yUpperLeft)),
            new Offset(
              levelPainter.getWidthFromDecimal(
                  xUpperLeft + (xBottomRight - xUpperLeft) * j / columns),
              levelPainter.getHeightFromDecimal(yBottomRight),
            ),
            paint);
        levelPainter.canvas.drawLine(
            new Offset(
                levelPainter.getWidthFromDecimal(xUpperLeft),
                levelPainter.getHeightFromDecimal(
                    yUpperLeft + (yBottomRight - yUpperLeft) * i / rows)),
            new Offset(
              levelPainter.getWidthFromDecimal(xBottomRight),
              levelPainter.getHeightFromDecimal(
                  yUpperLeft + (yBottomRight - yUpperLeft) * i / rows),
            ),
            paint);
      }
    }
    for (int i = 0; i < tiles.length; i++) {
      tiles[i] = false;
    }
  }

  void printTiles() {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.redAccent;
    List<bool> tmp = tiles;
    for (int i = 0; i < rows; i++) {
      print(tmp.sublist(columns * i, ((i + 1) * columns)));
    }
    /*for(int i = 0; i < midPoints.length; i++){
      if(tiles[i] == true){
        levelPainter.canvas.drawCircle(midPoints[i], 5, paint);
      }
    }*/
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

class Obstacle extends FieldElement {
  int id;
  int length; //length of the obstacle
  bool horizontal; //true = horizontal, false = vertical
  int tempX; //temporary x-value
  int tempY; //temporary y-value
  int currX; //current x-value
  int currY; //current y-value
  Obstacle old; //old backup of obstacle

  Obstacle(
      String color, int initialX, int initialY, int length, bool horizontal) {
    this.color = LevelPainter.hexToColor(color);
    this.initialX = initialX;
    this.initialY = initialY;
    this.currX = initialX;
    this.currY = initialY;
    this.length = length;
    this.horizontal = horizontal;
  }

  static Obstacle fromJson(dynamic data) {
    return Obstacle(data['color'], data['initX'], data['initY'], data['length'],
        data['horizontal']);
  }

  String toString() {
    return 'id: $id\n'
        'color: $color\n'
        'initX: $initialX\n'
        'initY: $initialY\n'
        'currX: $currX\n'
        'currY: $currY\n'
        'length: $length\n'
        'horizontal: $horizontal';
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
    if (this.horizontal == true) {
      levelPainter.canvas.drawCircle(
          grid.midPoints[(grid.rows * (currY - 1)) + (currX - 2 + length)],
          grid.width / 3,
          paint);
      levelPainter.canvas.drawRect(
          new Rect.fromPoints(
              new Offset(
                  grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
                  grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy -
                      grid.width / 3),
              new Offset(
                  grid
                      .midPoints[
                          (grid.rows * (currY - 1)) + (currX - 2 + length)]
                      .dx,
                  grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy +
                      grid.width / 3)),
          paint);
      for (int i = 0; i < length; i++) {
        grid.tiles[(grid.rows * (currY - 1)) + (currX - 1 + i)] = true;
      }
    } else {
      levelPainter.canvas.drawCircle(
          grid.midPoints[(grid.rows * (currY - 2 + length)) + (currX - 1)],
          grid.width / 3,
          paint);
      levelPainter.canvas.drawRect(
          new Rect.fromPoints(
              new Offset(
                  grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx -
                      grid.width / 3, //+
                  grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
              new Offset(
                  grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx +
                      grid.width / 3, //-
                  grid
                      .midPoints[
                          (grid.rows * (currY - 2 + length)) + (currX - 1)]
                      .dy)),
          paint);
      for (int i = 0; i < length; i++) {
        grid.tiles[(grid.rows * (currY - 1 + i)) + (currX - 1)] = true;
      }
    }
    levelPainter.canvas.drawCircle(
        grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)],
        grid.width / 2 - 3,
        whitePaint);
    //grid.printTiles();
  }
}

enum Direction { UP, DOWN, LEFT, RIGHT }

class Ball extends FieldElement {
  int id;
  int currX;
  int currY;
  Direction direction;
  Goal goal;

  Ball(String color, int initialX, int initialY, String direction) {
    this.color = LevelPainter.hexToColor(color);
    this.initialX = initialX;
    this.initialY = initialY;
    this.currX = initialX;
    this.currY = initialY;
    switch (direction) {
      case "up":
        this.direction = Direction.UP;
        break;
      case "down":
        this.direction = Direction.DOWN;
        break;
      case 'left':
        this.direction = Direction.LEFT;
        break;
      case 'right':
        this.direction = Direction.RIGHT;
        break;
    }
  }

  static Ball fromJson(dynamic data) {
    return Ball(data['color'], data['initX'], data['initY'], data['direction']);
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
    levelPainter.canvas.drawCircle(
        grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)],
        grid.width / 2 - 3,
        paint);
    if (direction == Direction.DOWN) {
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy +
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx -
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy +
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx +
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy +
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy -
                  grid.width / 3),
          whitePaint);
    } else if (direction == Direction.UP) {
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy -
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx -
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy -
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx +
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy -
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy +
                  grid.width / 3),
          whitePaint);
    } else if (direction == Direction.LEFT) {
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy -
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx -
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy +
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx -
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx -
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx +
                  grid.width / 3,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
    } else if (direction == Direction.RIGHT) {
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy +
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx +
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy -
                  grid.width / 4),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx +
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
      levelPainter.canvas.drawLine(
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx -
                  grid.width / 3,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          new Offset(
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dx +
                  grid.width / 4,
              grid.midPoints[(grid.rows * (currY - 1)) + (currX - 1)].dy),
          whitePaint);
    }
    grid.tiles[(grid.rows * (currY - 1)) + (currX - 1)] = true;
  }
}

class Goal extends FieldElement {
  int id;
  int currX;
  int currY;

  Goal(String color, int initialX, int initialY) {
    this.color = LevelPainter.hexToColor(color);
    this.initialX = initialX;
    this.initialY = initialY;
  }

  static Goal fromJson(dynamic data) {
    return Goal(
      data['color'],
      data['initX'],
      data['initY'],
    );
  }

  @override
  void draw() {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = color;
    levelPainter.canvas.drawRect(
        new Rect.fromCircle(
            center:
                grid.midPoints[(grid.rows * (initialY - 1)) + (initialX - 1)],
            radius: grid.width * 15 / 32),
        paint);
  }
}

//25 is the magic number for a 6x6 grid
