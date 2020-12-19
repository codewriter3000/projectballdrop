import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(DBall());
}

class DBall extends StatefulWidget {
  @override
  _DBallState createState() => _DBallState();
}

class _DBallState extends State<DBall>with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var DBall = new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Color(0xFF151515),
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
                        padding: EdgeInsets.only(left: 50, right: 50),
                        onPressed: () {
                          print("DBall");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Play()),
                          );
                        },
                        child: Card(
                            margin: EdgeInsets.fromLTRB(25, 130, 25, 5),
                            borderOnForeground: false,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "DBall",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Credits()),
                          );
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
                        padding: EdgeInsets.only(left: 50, right: 50),
                        onPressed: () {
                          print("Contribute");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Contribute()),
                          );
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
          );
        },
        ),
      ),
    );
    return DBall;
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
                    padding: EdgeInsets.all(20),
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
                          FlatButton(
                            padding: EdgeInsets.only(left: 100, right: 100),
                            onPressed: () {
                              print("Back");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DBall()),
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
                                        fontSize: 30,
                                        fontFamily: "Goldman"
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}

class Contribute extends StatefulWidget {
  @override
  _ContributeState createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFF151515),
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(20),
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
                          FlatButton(
                            padding: EdgeInsets.only(left: 100, right: 100),
                            onPressed: () {
                              print("Back");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DBall()),
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
                                        fontSize: 30,
                                        fontFamily: "Goldman"
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

//View
class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFF151515),
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Game",
                            style: TextStyle(
                              fontFamily: "Goldman",
                              //fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Text(
                            'yay this is the game',
                            style: TextStyle(
                              fontFamily: "Goldman",
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.only(left: 100, right: 100),
                            onPressed: () {
                              print("Back");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DBall()),
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
                                        fontSize: 30,
                                        fontFamily: "Goldman"
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}
