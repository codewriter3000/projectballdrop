///Alex Micharski Updated 2 Jan 2021
///Micharski Technologies (c)2021 All Rights Reserved
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_manager.dart';
import 'audio_controller.dart';
import 'controller.dart';
import 'main.dart';
import 'model.dart';
import 'level_generator.dart';

final changeNotifierMain = ChangeNotifier();

class GameView extends StatefulWidget {
  static int lvl = 0;
  static ValueNotifier<bool> lvlComplete = ValueNotifier(false);
  static int lvlQuantity = 21;

  static _GameViewState? of(BuildContext context) =>
      context.findAncestorStateOfType<_GameViewState>();

  @override
  _GameViewState createState(){
    return _GameViewState();
  }
}

class _GameViewState extends State<GameView> {
  late Level level;
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  late BannerAd _bannerAd2;
  bool _isBannerAd2Ready = false;
  late InterstitialAd _interAd;
  bool _isInterAdReady = false;
  late Color _backgroundColor;
  AudioController audioController = AudioController();
  Color setBackgroundFX(){
    print('Floor value: ${(GameView.lvl/2).floor()%5+1}');
    if(!GameView.lvlComplete.value){
      if(GameView.lvl%10 == 0){
        loadInterstitialAd();
      }
      audioController.playLoop((GameView.lvl/2).floor()%5+1);
      switch((GameView.lvl/2).floor()){
        case 0:
          _backgroundColor = Color(0xFF151515);
          break;
        case 1:
          _backgroundColor = Color(0xFF6B1010);
          break;
        case 2:
          _backgroundColor = Color(0xFF6B1E06);
          break;
        case 3:
          _backgroundColor = Color(0xFFAD3D00);
          break;
        case 4:
          _backgroundColor = Color(0xFFC4B700);
          break;
        case 5:
          _backgroundColor = Color(0xFF827717);
          break;
        case 6:
          _backgroundColor = Color(0xFF519602);
          break;
        case 7:
          _backgroundColor = Color(0xFF33691E);
          break;
        case 8:
          _backgroundColor = Color(0xFF1B5E20);
          break;
        case 9:
          _backgroundColor = Color(0xFF004D40);
          break;
        case 10:
          _backgroundColor = Color(0xFF006064);
          break;
        case 11:
          _backgroundColor = Color(0xFF01579B);
          break;
        case 12:
          _backgroundColor = Color(0xFF0D47A1);
          break;
        case 13:
          _backgroundColor = Color(0xFF1A237E);
          break;
        case 14:
          _backgroundColor = Color(0xFF311B92);
          break;
      }
    }
    return _backgroundColor;
  }

  void newLevel(){
    level = new Level(GameView.lvl);
    _backgroundColor = setBackgroundFX();
    level.execute().then((_) => setState(() {}));
  }

  @override
  void initState() {
    newLevel();
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();

    _bannerAd2 = BannerAd(
      adUnitId: AdManager.bannerAd2UnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAd2Ready = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAd2Ready = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd2.load();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> loadInterstitialAd() async {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));

    _interAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );

    _interAd.show();
  }

  @override
  void dispose(){
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(context);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValueListenableBuilder<bool>(
        valueListenable: GameView.lvlComplete,
          builder: (BuildContext context, bool lvlComplete, Widget? child)
    {
      return Scaffold(
        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_isBannerAdReady)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),
                Text(
                  GameView.lvlQuantity >= GameView.lvl ? GameView.lvlComplete
                      .value == false
                      ? "Level ${GameView.lvl}"
                      : "Level Complete" : "Game Complete",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Goldman",
                    //fontWeight: FontWeight.bold,
                    fontSize: GameView.lvlComplete.value == false ? 60 : 50,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 3/10, left: MediaQuery.of(context).size.width * 3/10, top: MediaQuery.of(context).size.height * 8.5/10),
                  child: TextButton(
                    //padding: EdgeInsets.only(left: 100, right: 100, top: 600),
                    onPressed: () {
                      /*print(
                          "###############################################");
                      print(
                          "###############################################");
                      print(
                          "###############################################");*/
                      audioController.pauseMusic();
                      if (GameView.lvl > 100) {
                        var customLvl = new LevelFactory();
                        customLvl.createLevel();
                      }
                      if (GameView.lvlQuantity < GameView.lvl) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DBall()),
                        );
                        return;
                      }
                      level.dispose();
                      GameView.lvlComplete = ValueNotifier(false);
                      newLevel();
                      //initState();
                    },
                    child: Card(
                      //margin: EdgeInsets.fromLTRB(25, 30, 25, 5),
                      borderOnForeground: false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            GameView.lvlQuantity >= GameView.lvl ? GameView
                                .lvlComplete.value == false
                                ? "Reset Level"
                                : "Next Level" : "Celebrate",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30, fontFamily: "Goldman"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  //width: MediaQuery.of(context).size.width/MediaQuery.of(context).devicePixelRatio,
                  //height: MediaQuery.of(context).size.height/MediaQuery.of(context).devicePixelRatio, //make it the distance between height and top of canvas
                  child: ClipRect(
                      child: GestureDetector(
                        onPanStart: (hi) {
                          Controller controller = new Controller();
                          controller.setStartDrag(hi.localPosition);
                        },
                        onPanUpdate: (hi) {
                          Controller controller = new Controller();
                          controller.setCurrentPos(hi.localPosition);
                          controller.moveObstacle();
                          controller.setStartDrag(hi.localPosition);
                        },
                        onPanEnd: (hi) {
                          Controller controller = new Controller();
                          controller.tryBallMove();
                          controller.getLevelPainter()!.changeNotifier
                              .notifyListeners();
                          controller.setStartDrag(Offset(0, 0));
                          controller.setCurrentPos(Offset(0, 0));
                        },
                        child: CustomPaint(
                            painter: LevelPainter(level, changeNotifierMain)
                        ),
                      )
                  ),
                ),
                if (_isBannerAd2Ready)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: _bannerAd2.size.width.toDouble(),
                      height: _bannerAd2.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd2),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
      ),
    );
  }
}

class LevelPainter extends CustomPainter {
  late Level level;
  late double canvasHeight;
  late double canvasWidth;
  late Canvas canvas;
  ChangeNotifier changeNotifier = changeNotifierMain;

  LevelPainter(this.level, Listenable repaint) : super(repaint: repaint) {
    changeNotifier.addListener(() => repaint);
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
    controller.setGrid(grid);
    controller.setLevelPainter(this);
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
    if (decimal.ceil() != 1 && decimal != 0) {
      throw new ScaleDecimalOutOfRangeException(decimal);
    } else {
      return decimal * canvasHeight;
    }
  }

  double getWidthFromDecimal(double decimal) {
    if (decimal.ceil() != 1 && decimal != 0) {
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
  late String _message;

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
  late LevelPainter levelPainter;
  late double xUpperLeft; //scale decimal
  late double yUpperLeft; //scale decimal
  late double magnitude; //scale decimal
  late int rows; //quantity of rows
  late int columns; //quantity of columns
  //needs to be filled manually by constructors
  late double xBottomRight; //scale decimal
  late double yBottomRight; //scale decimal
  late double cellWidth; //scale decimal
  late double cellHeight; //scale decimal
  late double width; //width of each cell
  late List<Offset> midPoints = List<Offset>.empty(growable: true); //scale decimals
  late List<bool> tiles = List<bool>.empty(
      growable: true); //detects whether a field element exists on this square

  Grid(xUpperLeft, yUpperLeft, magnitude, rows, columns) {
    this.xUpperLeft = xUpperLeft;
    this.yUpperLeft = yUpperLeft;
    this.magnitude = magnitude;
    this.rows = rows;
    this.columns = columns;
  }

  Grid.smallGrid(size) {
    this.rows = size;
    this.columns = size;
    this.xUpperLeft = 0.005;
    this.yUpperLeft = 0.01;
    this.magnitude = 0.98;
  }

  static Grid fromJson(dynamic data) {
    if(data.length == 1){
      return Grid.smallGrid(data['size']);
    }
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
        if(tiles.length != rows*columns){
          tiles.add(false);
        }
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
    double centerX = levelPainter.getHeightFromDecimal(0.5);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white;
    final blue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.blue;
    /*levelPainter.canvas.drawLine(
        new Offset(centerX,
            0
        ), new Offset(centerX,
        1000
    ), paint
    );*/
    setMidpoints();
    /*for(int i = 0; i < tiles.length; i++){
      levelPainter.canvas.drawCircle(
          midPoints[i]
          , 5
          , paint);
    }*/
    levelPainter.canvas.drawRect(
        Rect.fromPoints(
            new Offset(levelPainter.getWidthFromDecimal(xUpperLeft),
                levelPainter.getHeightFromDecimal(yUpperLeft)),
            new Offset(levelPainter.getWidthFromDecimal(xBottomRight),
                levelPainter.getHeightFromDecimal(yBottomRight))),
        paint);
    //TODO: puzzle isn't center-aligned
    /*double centerX = (levelPainter.getWidthFromDecimal(xUpperLeft) +
        levelPainter.getWidthFromDecimal(xUpperLeft + magnitude))/2;
    double centerY = (levelPainter.getHeightFromDecimal(xUpperLeft) +
        levelPainter.getWidthFromDecimal(xUpperLeft + magnitude))/2;

    levelPainter.canvas.drawLine(
        new Offset(
            centerX - (levelPainter.getWidthFromDecimal(magnitude)/2),
            centerY - (levelPainter.getHeightFromDecimal(magnitude)/2)
        ),
        new Offset(
            centerX + (levelPainter.getWidthFromDecimal(magnitude)/2),
            centerY + (levelPainter.getHeightFromDecimal(magnitude)/2)
        ),
        blue
    );*/
    for (int i = 1; i <= this.rows; i++) {
      for (int j = 1; j <= this.columns; j++) {
        //vertical
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
        //horizontal
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
      //print('imma lay you down on a bed of roses: $i');
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
    for(int i = 0; i < midPoints.length; i++){
      if(tiles[i] == true){
        print(i);
        levelPainter.canvas.drawCircle(
            midPoints[i]
            , 5
            , paint);
      }
    }
  }
}

abstract class FieldElement {
  late LevelPainter levelPainter;
  late Color color; //color of the field element
  late int initialX; //initial x-value
  late int initialY; //initial y-value
  late Grid grid; //grid that the field element is on

  void draw();
}

class Obstacle extends FieldElement {
  late int id;
  late int length; //length of the obstacle
  late bool horizontal; //true = horizontal, false = vertical
  late int tempX; //temporary x-value
  late int tempY; //temporary y-value
  late int currX; //current x-value
  late int currY; //current y-value
  late Obstacle old; //old backup of obstacle

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
  late int id;
  late int currX;
  late int currY;
  late Direction direction;
  late Goal goal;

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
  late int id;
  late int currX;
  late int currY;

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
