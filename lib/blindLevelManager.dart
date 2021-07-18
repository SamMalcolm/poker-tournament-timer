import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'controller/pokerGame.dart';

class BlindLevelManagerView extends StatefulWidget {
  BlindLevelManagerView(
      {Key? key, required this.game, required this.updateGame})
      : super(key: key);

  final PokerGame game;
  final Function updateGame;

  @override
  _BlindLevelManagerViewState createState() => _BlindLevelManagerViewState();
}

class _BlindLevelManagerViewState extends State<BlindLevelManagerView> {
  List<Map> blindValues = [];
  @override
  void initState() {
    blindValues = widget.game.blindLevels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      SizedBox(
        height: 10.0,
      ),
      Text("Blind Levels",
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontFamily: 'primaryBold')),
      SizedBox(
        height: 20.0,
      ),
      Text(
        "Blind Level Duration (Mins)",
        style: TextStyle(color: Colors.white, fontFamily: 'primaryBold'),
      ),
      TextField(
        keyboardType: TextInputType.number,
        onChanged: (input) {
          int value = int.parse(input);
          widget.game.blindLevelTime = 60 * value;
          widget.updateGame(widget.game);
        },
        style: TextStyle(color: Colors.white),
      ),
      Row(
        children: [
          Column(
            children: [
              Text("Small Blind"),
              Text("1"),
            ],
          ),
          Column(
            children: [
              Text("Big Blind"),
              Text("2"),
            ],
          )
        ],
      ),
      (blindValues.length >= 1)
          ? pokerButton(() {
              print("woop");
              setState(() {
                Map lastBlindLevel = blindValues[blindValues.length];
                lastBlindLevel['bb'] = lastBlindLevel['bb'] * 2;
                lastBlindLevel['sb'] = lastBlindLevel['sb'] * 2;
                blindValues.add(lastBlindLevel);
                widget.game.blindLevels = blindValues;
                widget.updateGame(widget.game);
              });
            }, "Add Level (x2)")
          : Text("No Blind Levels")
    ]);
  }
}
