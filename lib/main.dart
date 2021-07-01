import 'dart:async';
import 'dart:io';

import 'package:d_ball/tutorial.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:d_ball/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upgrader/upgrader.dart';

import 'ad_manager.dart';
import 'audio_controller.dart';

const _INTRO = 'intro.mp3';

AudioController audioController = AudioController();

void doNothing(){}

void main() async {
  runApp(DBall());
}

class DBall extends StatefulWidget {

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  _DBallState createState() {
    this._initGoogleMobileAds();
    return _DBallState();
  }
}

class _DBallState extends State<DBall> with SingleTickerProviderStateMixin {
  bool gameComplete = GameView.lvlQuantity < GameView.lvl;
  late ConfettiController _controller;
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  void playIntroAudio() async {
    _controller = ConfettiController(duration: Duration(seconds: 5));
    if(gameComplete){
      _controller.play();
      GameView.lvl = 0;
      GameView.lvlComplete.value = false;
    }
    audioController.playLoop(-1);
  }

  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid)
      InAppUpdate.performImmediateUpdate();
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAd0UnitId,
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
          print(err.responseInfo);
          print(err.code);
          print(err.domain);
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    playIntroAudio();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Color(0xFF151515),
              body: SafeArea(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        if (Platform.isIOS)
                          UpgradeAlert(child: Center(child: Text('Checking for updates...'))),
                        if (_isBannerAdReady)
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: _bannerAd.size.width.toDouble(),
                              height: _bannerAd.size.height.toDouble(),
                              child: AdWidget(ad: _bannerAd),
                            ),
                          ),
                        ConfettiWidget(
                          confettiController: _controller,
                          blastDirection: 0,
                          emissionFrequency: 0.05,
                          numberOfParticles: 10
                        ),
                        Text(
                          "D-Ball\nLite",
                          style: TextStyle(
                            fontFamily: "Goldman",
                            fontSize: 60,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        TextButton(
                          //padding: EdgeInsets.fromLTRB(25, 130, 25, 5),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameView()),
                            );
                          },
                          child: Card(
                              borderOnForeground: false,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  "DBall",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: "Goldman"),
                                ),
                              )),
                        ),
                        TextButton(
                          //padding: EdgeInsets.only(left: 100, right: 100),
                          onPressed: () {
                            //print("Credits");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Credits()),
                            );
                          },
                          child: Card(
                              //margin: EdgeInsets.fromLTRB(25, 50, 25, 50),
                              borderOnForeground: false,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  "Credits",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: "Goldman"),
                                ),
                              )),
                        ),
                        TextButton(
                          //padding: EdgeInsets.only(left: 50, right: 50),
                          onPressed: () {
                            //print("Contribute");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Contribute()),
                            );
                          },
                          child: Card(
                              //margin: EdgeInsets.fromLTRB(25, 50, 25, 50),
                              borderOnForeground: false,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  "Contribute",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: "Goldman"),
                                ),
                              )),
                        ),
                        TextButton(
                          //padding: EdgeInsets.only(left: 100, right: 100),
                          onPressed: () {
                            //print("Credits");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tutorial()),
                            );
                          },
                          child: Card(
                            //margin: EdgeInsets.fromLTRB(25, 50, 25, 50),
                              borderOnForeground: false,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  "Tutorial",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: "Goldman"),
                                ),
                              )),
                        ),
                        TextButton(
                          //padding: EdgeInsets.only(left: 100, right: 100),
                          onPressed: () {
                            //print("Credits");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tutorial()),
                            );
                          },
                          child: Card(
                            //margin: EdgeInsets.fromLTRB(25, 50, 25, 50),
                              borderOnForeground: false,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  "Full Version",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: "Goldman"),
                                ),
                              )),
                        ),
                      ]),
                ),
              ),
            );
          },
        ),
    );
  }
}

class Credits extends StatefulWidget {
  @override
  _CreditsState createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFF151515),
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Credits",
                            style: TextStyle(
                              fontFamily: "Goldman",
                              //fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Text(
                            "Lead and Only Developer: Alex Micharski",
                            style: TextStyle(
                              fontFamily: "Goldman",
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
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
                        ])))));
  }
}

class Contribute extends StatefulWidget {
  @override
  _ContributeState createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  Future fetchLevels() async {}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFF151515),
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Contribute",
                            style: TextStyle(
                              fontFamily: "Goldman",
                              //fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Text(
                            'Join our Discord Server: 3XuPBVt',
                            style: TextStyle(
                              fontFamily: "Goldman",
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
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
                        ])))));
  }
}
