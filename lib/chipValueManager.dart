import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';

class ChipValueManagerView extends StatefulWidget {
  ChipValueManagerView({Key? key}) : super(key: key);
  @override
  _ChipValueManagerViewState createState() => _ChipValueManagerViewState();
}

class _ChipValueManagerViewState extends State<ChipValueManagerView> {
  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      SizedBox(
        height: 10.0,
      ),
      Text("Chip Values",
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontFamily: 'primaryBold')),
      SizedBox(
        height: 20.0,
      ),
    ]);
  }
}
