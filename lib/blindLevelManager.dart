import 'package:flutter/material.dart';
import 'package:poker_tournament_timer/components/formFields.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'components/formFields.dart';
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
      {Key? key,
      required this.game,
      required this.updateGame,
      required this.updateMessage})
      : super(key: key);

  final PokerGame game;
  final Function updateGame;
  final Function updateMessage;

  @override
  _BlindLevelManagerViewState createState() => _BlindLevelManagerViewState();
}

class _BlindLevelManagerViewState extends State<BlindLevelManagerView> {
  List<dynamic> blindValues = [];
  int sb = 0;
  int bb = 0;
  TextEditingController sbController = new TextEditingController();
  TextEditingController bbController = new TextEditingController();
  int blindDuration = 0;
  var blindLevelTimeController = TextEditingController();
  @override
  void initState() {
    blindValues = widget.game.blindLevels;
    blindLevelTimeController.text =
        (widget.game.blindLevelTime / 60).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      pokerSpacer(),
      heading1("Blind Levels"),
      ...pokerDivider(),
      heading2("Blind Level Duration (Mins)"),
      pokerTextField((input) {
        int value = int.parse(input);
        blindDuration = value;
        widget.game.blindLevelTime = 60 * value;
        widget.updateGame(widget.game);
      }, expanded: false, controller: blindLevelTimeController),
      pokerSpacer(),
      pokerCheckbox(
          "Continue doubling blind levels indefinitely when timer runs out of predefined levels.\nWhen unchecked the timer will stay on the last level forever.",
          (bool? value) {
        setState(() {
          widget.game.blindLevelIndefinitelyDuplicateBehaviour = value!;
          widget.updateGame(widget.game);
        });
      }, widget.game.blindLevelIndefinitelyDuplicateBehaviour),
      pokerSpacer(),
      ...blindLevelDisplay(blindValues, setState),
      ...pokerDivider(),
      //
      Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              heading3("Small Blind"),
              pokerTextField((String s) {
                if (s != '') {
                  setState(() {
                    sb = int.parse(s);
                    bb = sb * 2;
                    bbController.text = bb.toString();
                  });
                }
              }, controller: sbController, expanded: false, numbersOnly: true)
            ]),
          ),
          SizedBox(width: 5.0),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              heading3("Big Blind"),
              pokerTextField((String s) {
                if (s != '') {
                  setState(() {
                    bb = int.parse(s);
                  });
                }
              }, controller: bbController, expanded: false, numbersOnly: true)
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
                blindValues.sort((a, b) => (a['sb'].compareTo(b['sb'])));
                widget.game.blindLevels = blindValues;
                widget.updateGame(widget.game);
              }
            });
          }, "Add Level"),
        ],
      ),
      ...pokerDivider(),
      (blindValues.length > 0 && blindDuration != 0)
          ? bodyText("Blind Levels will take " +
              (blindValues.length * blindDuration).toString() +
              ' Minutes to complete')
          : Text(""),
      pokerButton(() {
        widget.updateMessage("Updated Blind Levels", "success");
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
      }, "Done", colors: <Color>[
        Color.fromRGBO(0, 120, 70, 1),
        Color.fromRGBO(0, 90, 40, 1),
      ]),
      SizedBox(height: 20.0)
    ]);
  }
}
