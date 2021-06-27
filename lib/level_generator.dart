//randomly generates levels

import 'dart:io';
import 'package:d_ball/view.dart';
import 'package:path_provider/path_provider.dart';

import 'model.dart';

class LevelFactory {
  late Level level;
  late File levelFile;

  Future<File> _createLevelFile() async {
    Future<Directory> appDocDir = getApplicationDocumentsDirectory();
    File file = new File('${(await appDocDir).path}/levels/level101.json');
    return file;
  }

  Future<void> createLevel() async {
    levelFile = await _createLevelFile();
    levelFile.create(recursive: true);
    print('******');
    print(levelFile);
    level = new Level(101);
    level.grid = new Grid(0.1, 0.3, 0.7, 4, 4);

    levelFile.writeAsString("{\n}", mode: FileMode.append);
  }
}