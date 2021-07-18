import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';

class GameView extends StatefulWidget {
  GameView({Key? key}) : super(key: key);
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([]);
  }
}
