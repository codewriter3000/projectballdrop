import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import 'main.dart';

class AudioController {
  static final AudioController _audioController = new AudioController._internal();
  static AudioCache musicCache;
  static AudioPlayer instance;
  static const _INTRO = 'intro.mp3';

  factory AudioController(){
    return _audioController;
  }

  AudioController._internal(){
    doNothing();
    //print("Audio Controller is now implemented");
  }

  void playLoopedMusic(int song) async {
    if(instance != null){
      print("instance disposed");
      instance.pause();
      instance.dispose();
    }
    if(musicCache != null){
      musicCache.clearCache();
    }
    musicCache = AudioCache(prefix: "assets/");
    if(song >= 0){
      instance = await musicCache.loop("alpha$song.ogg");
    } else if(song == -1){
      instance = await musicCache.play(_INTRO);
    }
    instance.setVolume(1.0);
  }

  void pauseMusic(){
    if (instance != null){
      instance.pause();
    }
  }
}