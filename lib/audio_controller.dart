import 'package:audioplayers/audioplayers.dart';

import 'main.dart';

class AudioController {
  static final AudioController _audioController = AudioController._internal();
  AudioCache? _musicCache;
  AudioPlayer _instance = AudioPlayer(mode: PlayerMode.LOW_LATENCY, playerId: 'main');
  bool _isPlaying = false;

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
    _isPlaying = false;
    print("STOP PLAYING RESULT: $result");
    if(song == -1){
      _instance = await _musicCache!.play("intro.mp3");
      _isPlaying = true;
    } else {
      print(_isPlaying);
      if(!_isPlaying){
        _instance = await _musicCache!.loop("alpha$song.ogg");
        if(song != 1){
          _instance.setVolume(0.5);
        }
        _isPlaying = true;
        print("I'M PLAYING NOW BUDDY");
      }
    }
  }

  void pauseMusic(){
    print("music paused");
    _instance.pause();
    _isPlaying = false;
  }
}