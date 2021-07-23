import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'controller/pokerGame.dart';

List<Widget> blindLevelDisplay(blindValues) {
  List<Widget> output = [];

  output.add(Row(mainAxisSize: MainAxisSize.max, children: [
    Expanded(
      child: Text(
        "Small Blind",
        style: TextStyle(color: Colors.white),
      ),
    ),
    Expanded(
      child: Text(
        "Big Blind",
        style: TextStyle(color: Colors.white),
      ),
    )
  ]));

  for (int i = 0; i < blindValues.length; i++) {
    output.add(Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
        child: Text(
          '\$' + blindValues[i]['sb'].toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      Expanded(
        child: Text(
          '\$' + blindValues[i]['bb'].toString(),
          style: TextStyle(color: Colors.white),
        ),
      )
    ]));
  }
  return output;
}

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
  int sb = 0;
  int bb = 0;
  TextEditingController sbController = new TextEditingController();
  TextEditingController bbController = new TextEditingController();

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
      SizedBox(height: 25.0),
      ...blindLevelDisplay(blindValues),
      //
      Row(
        children: [
          Expanded(
            child: Column(children: [
              Text("Small Blind", style: TextStyle(color: Colors.white)),
              TextField(
                  controller: sbController,
                  onChanged: (String s) {
                    print(s);
                    if (s != '') {
                      setState(() {
                        sb = int.parse(s);
                        bb = sb * 2;
                        bbController.text = bb.toString();
                      });
                    }
                  },
                  style: TextStyle(color: Colors.white)),
            ]),
          ),
          Expanded(
            child: Column(children: [
              Text("Big Blind", style: TextStyle(color: Colors.white)),
              TextField(
                  controller: bbController,
                  onChanged: (String s) {
                    if (s != '') {
                      setState(() {
                        bb = int.parse(s);
                      });
                    }
                  },
                  style: TextStyle(color: Colors.white))
            ]),
          ),
          pokerButton(() {
            setState(() {
              Map blindLevel = {};
              blindLevel['sb'] = sb;
              blindLevel['bb'] = bb;
              blindValues.add(blindLevel);
              widget.game.blindLevels = blindValues;
              widget.updateGame(widget.game);
            });
          }, "Add Level", colors: <Color>[
            Color.fromRGBO(0, 120, 70, 1),
            Color.fromRGBO(0, 90, 40, 1),
          ])
        ],
      ),
      (blindValues.length >= 1)
          ? pokerButton(() {
              setState(() {
                Map lastBlindLevel = blindValues[blindValues.length - 1];
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
