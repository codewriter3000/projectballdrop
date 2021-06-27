///Alex Micharski Updated 2 Jan 2021
///Micharski Technologies (c)2021 All Rights Reserved

//tells the view how to move

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'view.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('levels/level${GameView.lvl}.json');
}

class Level extends ChangeNotifier {
  late Future<String> file;
  late Grid grid;
  late var ball;
  late var goal;
  late List<Obstacle> obstacles;
  late int id;
  late Map<String, dynamic> decodedJson;

  Level(int id) {
    print("Constructor is constructing");
  }

  Future execute() async {
    await loadAsset();
    this.file = loadAsset();
    decodedJson = json.decode(await file);
    id = decodedJson['id'];
    grid = Grid.fromJson(decodedJson['grid']);
    ball = Ball.fromJson(decodedJson['ball']['1']);
    goal = Goal.fromJson(decodedJson['goal']['1']);
    // String color, int initialX, int initialY, int length, bool horizontal
    obstacles = [];
    for (int i = 1; i <= decodedJson['obstacles'].length; i++) {
      obstacles.add(Obstacle.fromJson(decodedJson['obstacles']['$i']));
    }
  }
}
