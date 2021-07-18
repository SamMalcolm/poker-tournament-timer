import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_tournament_timer/chipValueManager.dart';
import 'blindLevelManager.dart';
import 'chipValueManager.dart';
import 'gameView.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'controller/pokerGame.dart';

class GameSetupView extends StatefulWidget {
  GameSetupView({Key? key}) : super(key: key);
  @override
  _GameSetupViewState createState() => _GameSetupViewState();
}

class _GameSetupViewState extends State<GameSetupView> {
  PokerGame game = PokerGame();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      SizedBox(
        height: 10.0,
      ),
      Text("Game Setup",
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontFamily: 'primaryBold')),
      SizedBox(
        height: 20.0,
      ),
      Text(
        "Game Name",
        style: TextStyle(color: Colors.white, fontFamily: 'primaryBold'),
      ),
      TextField(
        onChanged: (String string) {
          print(string);
        },
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        "Players",
        style: TextStyle(color: Colors.white),
      ),
      TextField(
        keyboardType: TextInputType.number,
        onChanged: (String string) {
          print(string);
        },
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(
        height: 15.0,
      ),
      pokerButton(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlindLevelManagerView(
                  game: game,
                  updateGame: (g) {
                    setState(() {
                      game = g;
                      print(game);
                    });
                  }),
            ));
      }, "Blind Levels"),
      pokerButton(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChipValueManagerView(),
            ));
      }, "Chip Values"),
      pokerButton(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameView(),
            ));
      }, "Start Game", colors: <Color>[
        Color.fromRGBO(0, 120, 70, 1),
        Color.fromRGBO(0, 90, 40, 1),
      ]),
      pokerButton(() {
        Navigator.pop(context);
      }, "Cancel", colors: <Color>[
        Color.fromRGBO(153, 153, 153, 1),
        Color.fromRGBO(102, 102, 102, 1),
      ])
    ]);
  }
}
