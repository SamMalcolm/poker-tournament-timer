import 'dart:convert';
import 'package:intl/intl.dart';

class PokerGame {
  // Describse how the timre should work when the blind levels run out,
  // true will keep doubling the blind level at the required interval
  // false will leaeve it on the last blind level indefinitely
  bool blindLevelIndefinitelyDuplicateBehaviour = false;

  int playerCount = 0;
  String gameName = "";
  List<dynamic> chips = [];
  List<dynamic> blindLevels = [];
  bool paused = true;
  bool allowPeopleToJoin = false;
  int blindLevelTime = 600;
  DateTime dateCreated = DateTime.now();
  DateTime dateUpdated = DateTime.now();

  Map<String, dynamic> toJsonPrep() => {
        'gameName': gameName,
        'blindLevelIndefinitelyDuplicateBehaviour':
            blindLevelIndefinitelyDuplicateBehaviour,
        'allowPeopleToJoin': allowPeopleToJoin,
        'blindLevelTime': blindLevelTime,
        'playerCount': playerCount,
        'chips': chips,
        'blindLevels': blindLevels,
        'dateCreated': DateFormat('MMddyyyyHHmmss').format(dateCreated),
        'dateUpdated': DateFormat('MMddyyyyHHmmss').format(dateUpdated)
      };

  String gameToString() {
    return jsonEncode(toJsonPrep());
  }

  DateTime dateTimeFromString(String str) {
    String dateWithT = str.substring(0, 8) + 'T' + str.substring(8);
    return DateTime.parse(dateWithT);
  }

  PokerGame updateFromJson(obj) {
    print(this.gameName);
    this.gameName = obj['gameName'];
    this.blindLevels = obj['blindLevels'];
    this.chips = obj['chips'];
    this.dateCreated = dateTimeFromString(obj['dateCreated']);
    this.dateUpdated = dateTimeFromString(obj['dateUpdated']);
    this.blindLevelIndefinitelyDuplicateBehaviour =
        obj['blindLevelIndefinitelyDuplicateBehaviour'];
    this.blindLevelTime = obj['blindLevelTime'];
    this.playerCount = obj['playerCount'];
    this.allowPeopleToJoin = obj['allowPeopleToJoin'];
    return this;
  }

  PokerGame();
}
