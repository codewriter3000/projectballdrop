import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:video_player/video_player.dart';

import 'audio_controller.dart';
import 'main.dart';

class Tutorial extends StatefulWidget {
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  @override
  State<StatefulWidget> createState() {
    this._initGoogleMobileAds();
    return _TutorialState();
  }
}

  class _TutorialState extends State<Tutorial> {
    AudioController _audioController = AudioController();
    late VideoPlayerController _controller;

    @override
    void initState() {
      _audioController.pauseMusic();
      super.initState();
      _controller = VideoPlayerController.asset('assets/dballtutorial.mp4')
        ..initialize().then((_){
        setState((){});
      });
      if(Platform.isAndroid)
        InAppUpdate.performImmediateUpdate();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        home: Builder(
          builder: (BuildContext context){
            return Scaffold(
              backgroundColor: Color(0xFF151515),
              body: Column(
                children: <Widget>[
                  Center(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : Container(),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                  TextButton(
                    //padding: EdgeInsets.only(left: 100, right: 100),
                    onPressed: () {
                      print("Back");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DBall()),
                      );
                    },
                    child: Card(
                        margin: EdgeInsets.fromLTRB(25, 130, 25, 5),
                        borderOnForeground: false,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Back",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30, fontFamily: "Goldman"),
                          ),
                        )),
                  ),
                ]
              )
            );
          }
        )
      );
    }

  }