import 'dart:convert';
import 'fileController.dart';
import 'package:intl/intl.dart';

class PokerGame {
  List<Map> blindLevels = [];

  // Describse how the timre should work when the blind levels run out,
  // true will keep doubling the blind level at the required interval
  // false will leaeve it on the last blind level indefinitely
  bool blindLevelIndefinitelyDuplicateBehaviour = false;

  int playerCount = 0;
  String gameName = "";
  List<Map> chips = [];
  bool paused = true;
  int blindLevelTime = 600;
  DateTime dateCreated = DateTime.now();
  DateTime dateUpdated = DateTime.now();

  Map<String, dynamic> toJsonPrep() => {
        'gameName': gameName,
        'blindLevelIndefinitelyDuplicateBehaviour':
            blindLevelIndefinitelyDuplicateBehaviour,
        'blindLevelTime': blindLevelTime,
        'chips': chips,
        'blindLevels': blindLevels,
        'dateCreated': DateFormat('MMddyyyyHHmmss').format(dateCreated),
        'dateUpdated': DateFormat('MMddyyyyHHmmss').format(dateUpdated)
      };

  String gameToString() {
    return jsonEncode(toJsonPrep());
  }

  void updateGameFromFile(filePath) async {
    String fileContents = await readFile(filePath);
    print(fileContents);
    // List<dynamic> list = json.decode(fileContents);
    // print(list);

    // dateUpdated = DateTime.now();
    // dateCreated = DateTime.parse(data['dateCreated']);
    // gameName = data['gameName'];
    // blindLevelTime = int.parse(data['blindLevelTime']);
    // blindLevels = data['blindLevels'];
    // chips = data['chips'];
    // blindLevelIndefinitelyDuplicateBehaviour =
    //     (data['blindLevelIndefinitelyDuplicateBehaviour'] == "true");
  }

  PokerGame();
}
