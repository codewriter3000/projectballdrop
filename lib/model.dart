//tells the view how to move

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'view.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('levels/level1.json');
}

class Level {
  Future<String> file;
  Grid grid;
  var ball;
  var goal;
  List<Obstacle> obstacles;
  int id;
  Map<String, dynamic> decodedJson;

  Level(int id){
    print("Constructor is constructing");
  }

  Future execute() async {
    await loadAsset();
    this.file = loadAsset();
    decodedJson = json.decode(await file);
    id = decodedJson['id'];
    grid = Grid.fromJson(decodedJson['grid']);
    ball = Ball.fromJson(decodedJson['ball']['1']);//(decodedJson['ball'] as List).map((data) => Ball.fromJson(data)).toList();
    goal = Goal.fromJson(decodedJson['goal']['1']);
    obstacles = List<Obstacle>();
    for(int i = 1; i <= decodedJson['obstacles'].length; i++){
      obstacles.add(Obstacle.fromJson(decodedJson['obstacles']['$i']));
    }
    //obstacles = null;//(decodedJson['obstacles'] as List).map((data) => Obstacle.fromJson(data)).toList();
    //print('obstacles: $obstacles');
  }
}

/*
{
  "level": {
    "id": 1,
    "grid": {
      "xUpperLeft": 0.05,
      "yUpperLeft": 0.05,
      "magnitude": 0.9,
      "rows": 6,
      "columns": 6
    },
    "ball": {
      "color": "0xFFF44336",
      "initX": 4,
      "initY": 3,
      "direction": "down"
    },
    "goal": {
      "color": "0xFFF44336",
      "initX": 4,
      "initY": 6
    },
    "obstacles": {
      "1": {
        "color": "0xFF4CAF50",
        "initX": 1,
        "initY": 3,
        "length": 3,
        "horizontal": false
      },
      "2": {
        "color": "0xFF795548",
        "initX": 2,
        "initY": 1,
        "length": 2,
        "horizontal": true
      },
      "3": {
        "color": "0xFF009688",
        "initX": 4,
        "initY": 1,
        "length": 3,
        "horizontal": true
      },
      "4": {
        "color": "0xFFFF9800",
        "initX": 2,
        "initY": 2,
        "length": 2,
        "horizontal": false
      },
      "5": {
        "color": "0xFFFFEB3B",
        "initX": 6,
        "initY": 2,
        "length": 2,
        "horizontal": false
      },
      "6": {
        "color": "0xFF2196F3",
        "initX": 3,
        "initY": 4,
        "length": 3,
        "horizontal": true
      },
      "7": {
        "color": "0xFF9C27B0",
        "initX": 1,
        "initY": 6,
        "length": 3,
        "horizontal": true
      }
    }
  }
}
 */