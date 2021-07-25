import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:poker_tournament_timer/chipValueManager.dart';
import 'savedConfigView.dart';
import 'blindLevelManager.dart';
import 'chipValueManager.dart';
import 'gameView.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'controller/pokerGame.dart';
import 'controller/fileController.dart';
import 'components/divider.dart';
import 'components/typography.dart';
import 'components/formFields.dart';
import 'package:intl/intl.dart';

class GameSetupView extends StatefulWidget {
  GameSetupView({Key? key}) : super(key: key);
  @override
  _GameSetupViewState createState() => _GameSetupViewState();
}

class _GameSetupViewState extends State<GameSetupView> {
  PokerGame game = PokerGame();
  var gameNameController = TextEditingController();

  @override
  void initState() {
    game.gameName = "My Game";
    gameNameController.text = game.gameName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      pokerSpacer(),
      heading1("Game Setup"),
      pokerSpacer(),
      heading2("Game Name"),
      pokerTextField((String string) {
        setState(() {
          game.gameName = string;
        });
      }, expanded: false, controller: gameNameController),
      pokerSpacer(),
      heading2("Players"),
      pokerTextField((String string) {
        setState(() {
          game.playerCount = int.parse(string);
        });
      }, expanded: false, numbersOnly: true),
      ...pokerDivider(),
      pokerButton(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlindLevelManagerView(
                    game: game,
                    updateGame: (PokerGame g) {
                      setState(() {
                        game = g;
                      });
                    })));
      }, "Blind Levels"),
      pokerButton(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChipValueManagerView(
                game: game,
                updateGame: (PokerGame g) {
                  setState(() {
                    game = g;
                  });
                },
              ),
            ));
      }, "Chip Values"),
      pokerButton(() {
        save(
            game.gameName,
            game.gameToString(),
            //DateFormat('yyyy-MM-dd-kk:mm').format(
            game.dateCreated.toString());
      }, "Save Game Settings"),
      pokerButton(() async {
        var files = await readDir();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SavedConfigView(
                configFiles: files,
                updateGameFromFile: (filepath) {
                  setState(() {
                    game.updateGameFromFile(filepath);
                  });
                },
              ),
            ));
      }, "Load Game Settings"),
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
