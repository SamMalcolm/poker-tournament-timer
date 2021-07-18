import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/buttons.dart';

class GameSetupView extends StatefulWidget {
  GameSetupView({Key? key}) : super(key: key);
  @override
  _GameSetupViewState createState() => _GameSetupViewState();
}

class _GameSetupViewState extends State<GameSetupView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
              Color.fromRGBO(35, 39, 88, 1),
              Color.fromRGBO(0, 0, 0, 1)
            ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Game Setup",
                        style: TextStyle(color: Colors.white, fontSize: 24.0)),
                    SizedBox(
                      height: 10.0,
                    ),
                    pokerButton(() {
                      Navigator.pop(context);
                    }, "Configure Blind Levels"),
                    pokerButton(() {
                      Navigator.pop(context);
                    }, "Configure Poker Chip Values"),
                    pokerButton(() {
                      Navigator.pop(context);
                    }, "Start Game"),
                    pokerButton(() {
                      Navigator.pop(context);
                    }, "Cancel", colors: <Color>[
                      Color.fromRGBO(153, 153, 153, 1),
                      Color.fromRGBO(102, 102, 102, 1),
                    ])
                  ]),
            )));
  }
}
