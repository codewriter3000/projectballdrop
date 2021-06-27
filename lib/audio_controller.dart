import 'package:audioplayers/audioplayers.dart';

import 'main.dart';

class AudioController {
  static final AudioController _audioController = AudioController._internal();
  AudioCache? _musicCache;
  AudioPlayer _instance = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  factory AudioController(){
    return _audioController;
  }

  AudioController._internal(){
    doNothing();
    //print("Audio Controller is now implemented");
  }

  Future<void> playLoop(int song) async {
    if(_musicCache == null) {
      _musicCache = AudioCache(prefix: "assets/");
    }
    int? result = await _instance.stop();
    print("RESULT: $result");
    if(song == -1){
      _instance = await _musicCache!.play("intro.mp3");
    } else {
      _instance = await _musicCache!.loop("alpha$song.ogg");
    }
  }

  void pauseMusic(){
    print("music paused");
    _instance.pause();
  }
}