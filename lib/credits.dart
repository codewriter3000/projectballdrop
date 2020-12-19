import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

class Credits extends StatefulWidget {
  @override
  _CreditsState createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xFF1515FF),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "D-Ball Alpha",
                      style: TextStyle(
                        fontFamily: "Goldman",
                        //fontWeight: FontWeight.bold,
                        fontSize: 60,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Text(
                      "Warning: The game may not work as intended.",
                      style: TextStyle(
                        fontFamily: "Goldman",
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(left: 100, right: 100),
                      onPressed: () {
                        print("Play");
                      },
                      child: Card(
                          margin: EdgeInsets.fromLTRB(25, 130, 25, 5),
                          borderOnForeground: false,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Play",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Goldman"
                              ),
                            ),
                          )
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(left: 100, right: 100),
                      onPressed: () {
                        print("Credits");
                      },
                      child: Card(
                        //margin: EdgeInsets.fromLTRB(25, 50, 25, 50),
                          borderOnForeground: false,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Credits",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Goldman"
                              ),
                            ),
                          )
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(left: 100, right: 100),
                      onPressed: () {
                        print("Contribute");
                      },
                      child: Card(
                        //margin: EdgeInsets.fromLTRB(25, 50, 25, 50),
                          borderOnForeground: false,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Contribute",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Goldman"
                              ),
                            ),
                          )
                      ),
                    ),
                  ]),
            ),
          ),
      )
    );
  }
}
