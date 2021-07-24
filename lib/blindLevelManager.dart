import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'controller/pokerGame.dart';
import 'components/typography.dart';
import 'components/divider.dart';

List<Widget> blindLevelDisplay(blindValues, setState) {
  List<Widget> output = [];
  if (blindValues.length > 0) {
    output.add(Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
        child: heading3("Small Blind"),
      ),
      Expanded(
        child: heading3("Big Blind"),
      ),
      Expanded(
        child: Text(
          "",
          style: TextStyle(color: Colors.white),
        ),
      )
    ]));
  }

  for (int i = 0; i < blindValues.length; i++) {
    output.add(Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
        child: bodyText(
          '\$' + blindValues[i]['sb'].toString(),
        ),
      ),
      Expanded(
        child: bodyText(
          '\$' + blindValues[i]['bb'].toString(),
        ),
      ),
      pokerButton(() {
        setState(() {
          blindValues.removeAt(i);
        });
      }, "Delete", colors: <Color>[
        Color.fromRGBO(147, 0, 0, 1),
        Color.fromRGBO(109, 0, 0, 1),
      ])
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
  int blindDuration = 0;

  @override
  void initState() {
    blindValues = widget.game.blindLevels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      SizedBox(
        height: 25.0,
      ),
      heading1("Blind Levels"),
      ...pokerDivider(),
      heading2("Blind Level Duration"),
      TextField(
        keyboardType: TextInputType.number,
        onChanged: (input) {
          int value = int.parse(input);
          blindDuration = value;
          widget.game.blindLevelTime = 60 * value;
          widget.updateGame(widget.game);
        },
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(height: 20.0),
      CheckboxListTile(
        checkColor: Colors.white,
        title: bodyText(
            "Continue doubling blind levels indefinitely when timer runs out of predefined levels? When unchecked the timer will stay on the last level forever.",
            size: 12.0),
        value: widget.game.blindLevelIndefinitelyDuplicateBehaviour,
        onChanged: (bool? value) {
          setState(() {
            widget.game.blindLevelIndefinitelyDuplicateBehaviour = value!;
            widget.updateGame(widget.game);
          });
        },
      ),

      SizedBox(height: 25.0),
      ...blindLevelDisplay(blindValues, setState),
      ...pokerDivider(),
      //
      Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              heading3("Small Blind"),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              heading3("Big Blind"),
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
              if (sb != 0 && bb != 0) {
                Map blindLevel = {};
                blindLevel['sb'] = sb;
                blindLevel['bb'] = bb;
                sb = sb * 2;
                bb = bb * 2;
                sbController.text = sb.toString();
                bbController.text = bb.toString();
                blindValues.add(blindLevel);
                widget.game.blindLevels = blindValues;
                widget.updateGame(widget.game);
              }
            });
          }, "Add Level", colors: <Color>[
            Color.fromRGBO(0, 120, 70, 1),
            Color.fromRGBO(0, 90, 40, 1),
          ]),
        ],
      ),
      ...pokerDivider(),
      (blindValues.length > 0 && blindDuration != 0)
          ? bodyText("Blind Levels will take " +
              (blindValues.length * blindDuration).toString() +
              ' Minutes to complete')
          : Text(""),
      pokerButton(() {
        Navigator.pop(context);
      }, "Done", colors: <Color>[
        Color.fromRGBO(0, 120, 70, 1),
        Color.fromRGBO(0, 90, 40, 1),
      ]),
      SizedBox(height: 20.0)
    ]);
  }
}
