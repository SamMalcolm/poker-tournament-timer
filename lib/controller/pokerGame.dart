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

  PokerGame();
}
