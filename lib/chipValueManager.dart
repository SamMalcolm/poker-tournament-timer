import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_tournament_timer/components/formFields.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'components/divider.dart';
import 'components/typography.dart';
import 'controller/pokerGame.dart';

List<Widget> displayChips(chipValues) {
  List<Widget> output = [];
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
  Widget build(BuildContext context) {
    return mainViewTemplate([
      pokerSpacer(),
      heading1("Chip Values"),
      pokerSpacer(),
      ...displayChips(chipValues),
      ...pokerDivider(),
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
          pokerTextField((String value) {}),
          pokerTextField((String value) {}),
          pokerTextField((String value) {}),
        ],
      ),
      pokerSpacer(),
      Image.asset('assets/' + chipColour.toLowerCase() + '.png',
          width: 70.0, height: 70.0),
      pokerSpacer(),
      pokerButton(() {}, "Add", colors: <Color>[
        Color.fromRGBO(0, 120, 70, 1),
        Color.fromRGBO(0, 90, 40, 1),
      ])
    ]);
  }
}
