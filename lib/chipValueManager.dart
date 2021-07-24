import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_tournament_timer/components/formFields.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'components/divider.dart';
import 'components/typography.dart';
import 'controller/pokerGame.dart';

List<Widget> displayChips(chipValues, setState) {
  List<Widget> output = [];
  for (int i = 0; i < chipValues.length; i++) {
    List<Widget> chipRow = [];
    chipRow.add(Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset(
            'assets/' + chipValues[i]['colour'].toLowerCase() + '.png'),
      ),
    ));
    chipRow.add(
        Expanded(child: heading3(intToDollarValue(chipValues[i]['value']))));
    chipRow.add(Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      bodyText("Start: " + chipValues[i]['startingStack'].toString(),
          size: 11.00),
      bodyText("x20: " + intToDollarValue((chipValues[i]['value'] * 20)),
          size: 11.00),
    ])));
    chipRow.add(pokerButton(() {
      setState(() {
        chipValues.removeAt(i);
      });
    }, "Delete", colors: <Color>[
      Color.fromRGBO(147, 0, 0, 1),
      Color.fromRGBO(109, 0, 0, 1),
    ]));
    output.add(Row(children: [...chipRow]));
  }
  return output;
}

class ChipValueManagerView extends StatefulWidget {
  ChipValueManagerView({Key? key, required this.game, required this.updateGame})
      : super(key: key);
  final PokerGame game;
  final Function updateGame;
  @override
  _ChipValueManagerViewState createState() => _ChipValueManagerViewState();
}

class _ChipValueManagerViewState extends State<ChipValueManagerView> {
  List<Map> chipValues = [];
  String chipColour = "White";
  int chipValue = 0;
  int startingStack = 0;
  int availableChips = 0;

  @override
  void initState() {
    chipValues = widget.game.chips;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      pokerSpacer(),
      heading1("Chip Values"),
      pokerSpacer(),
      ...displayChips(chipValues, setState),
      ...pokerDivider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: heading3("Colour", fontSize: 14.00)),
          SizedBox(
            width: 3.0,
          ),
          Expanded(child: heading3("Value", fontSize: 14.00)),
          SizedBox(
            width: 3.0,
          ),
          Expanded(child: heading3("Starting Stack", fontSize: 14.00)),
        ],
      ),
      pokerSpacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          dropDownField(chipColour, <String>[
            'White',
            'Green',
            'Red',
            'Black',
            'Blue',
            'Pink',
            'Orange',
            'Purple',
            'Grey'
          ], (String? value) {
            setState(() {
              if (value != null) {
                chipColour = value;
              }
            });
          }),
          SizedBox(
            width: 3.0,
          ),
          pokerTextField((String value) {
            setState(() {
              chipValue = int.parse(value);
            });
          }, numbersOnly: true),
          SizedBox(
            width: 3.0,
          ),
          pokerTextField((String value) {
            setState(() {
              startingStack = int.parse(value);
            });
          }, numbersOnly: true),
        ],
      ),
      pokerSpacer(),
      pokerButton(() {
        setState(() {
          Map chip = {};
          chip['value'] = chipValue;
          chip['colour'] = chipColour;
          chip['startingStack'] = startingStack;
          chipValues.add(chip);
          chipValues.sort((a, b) => a['value'].compareTo(b['value']));
          widget.game.chips = chipValues;
          widget.updateGame(widget.game);
        });
      }, "Add"),
      ...pokerDivider(),
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
