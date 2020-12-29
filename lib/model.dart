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
  //static var jsonLevels = jsonDecode('levels.json');
  Future<String> file;
  Grid grid;
  Ball ball;
  Goal goal;
  List<Obstacle> obstacle;
  int id;
  Map<String, dynamic> decodedJson;

  Level(int id){
    print("Constructor is constructing");
  }

  Future execute() async {
    await loadAsset();
    this.file = loadAsset();
    decodedJson = json.decode(await file);
    print(decodedJson.keys.toList());
    id = decodedJson['id'];
    print("id: $id");
    grid = decodedJson['grid'];
    print("grid: $grid");
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