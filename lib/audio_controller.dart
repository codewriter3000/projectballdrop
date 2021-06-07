import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import 'main.dart';

class AudioController {
  static final AudioController _audioController = new AudioController._internal();
  static AudioCache musicCache;
  static AudioPlayer instance = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  factory AudioController(){
    return _audioController;
  }

  AudioController._internal(){
    doNothing();
    //print("Audio Controller is now implemented");
  }

  Future playLoop(int song) async {
    if(musicCache == null) {
      musicCache = AudioCache(prefix: "assets/");
    }
    if(instance != null){
      int result = await instance.stop();
      print("RESULT: $result");
    }
    if(song == -1){
      instance = await musicCache.play("intro.mp3");
    } else {
      instance = await musicCache.loop("alpha$song.ogg");
    }
  }

  void pauseMusic(){
    if (instance != null){
      print("music paused");
      instance.pause();
    }
  }

  void kill(){
    if(instance != null){
      print("instance stopped");
      instance.stop();
    }
  }
}