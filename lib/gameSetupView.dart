import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
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

class GameSetupView extends StatefulWidget {
  GameSetupView({Key? key}) : super(key: key);
  @override
  _GameSetupViewState createState() => _GameSetupViewState();
}

class _GameSetupViewState extends State<GameSetupView> {
  PokerGame game = PokerGame();
  var gameNameController = TextEditingController();
  var playerCountController = TextEditingController();
  String activityMessage = "";
  String messageType = "success";

  @override
  void initState() {
    game.gameName = "My Game";
    gameNameController.text = game.gameName;
    super.initState();
  }

  void updateActivityMessage(message, type) {
    setState(() {
      activityMessage = message;
      messageType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      pokerSpacer(),
      heading1("Game Setup"),
      (activityMessage != "")
          ? bodyText(activityMessage,
              color: (messageType == "success")
                  ? Color.fromRGBO(0, 255, 0, 1)
                  : Color.fromRGBO(255, 0, 0, 1))
          : pokerSpacer(),
      pokerSpacer(),
      heading2("Game Name"),
      pokerTextField((String string) {
        setState(() {
          game.gameName = string;
        });
      }, expanded: false, controller: gameNameController, noSpecialChars: true),
      pokerSpacer(),
      heading2("Players"),
      pokerTextField((String string) {
        setState(() {
          game.playerCount = int.parse(string);
        });
      }, expanded: false, numbersOnly: true, controller: playerCountController),
      pokerCheckbox("Allow others on your local network to join this game",
          (bool? value) {
        setState(() {
          game.allowPeopleToJoin = value!;
        });
      }, game.allowPeopleToJoin),
      pokerSpacer(),
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
                    },
                    updateMessage: updateActivityMessage)));
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
                  updateMessage: updateActivityMessage),
            ));
      }, "Chip Values"),
      pokerButton(() {
        save(game.gameName, game.gameToString(),
            DateFormat('yyyyddMMHHmmss').format(game.dateCreated));
        updateActivityMessage("Game Configuration Saved", "success");
      }, "Save Game Settings", colors: <Color>[
        Color.fromRGBO(50, 50, 50, 1),
        Color.fromRGBO(20, 20, 20, 1)
      ]),
      pokerButton(() async {
        var files = await readDir();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SavedConfigView(
                  configFiles: files,
                  updateGameFromFile: (filepath) async {
                    String fileContents = await readFile(filepath);
                    var obj = json.decode(fileContents);
                    setState(() {
                      game = game.updateFromJson(obj);
                      gameNameController.text = game.gameName;
                      playerCountController.text = game.playerCount.toString();
                    });
                  },
                  updateMessage: updateActivityMessage),
            ));
      }, "Load Game Settings", colors: <Color>[
        Color.fromRGBO(50, 50, 50, 1),
        Color.fromRGBO(20, 20, 20, 1)
      ]),
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
