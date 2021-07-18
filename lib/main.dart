import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gameSetupView.dart';
import 'components/buttons.dart';
import 'components/mainViewTemplate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poker Tournament Timer',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
            button:
                TextStyle(color: Colors.white, backgroundColor: Colors.white)),
        primarySwatch: Colors.orange,
        backgroundColor: Colors.blue,
        accentColor: Colors.orange,
      ),
      home: MyHomePage(title: 'Poker Tournament Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned.fill(
            child: FittedBox(
              child: Image.asset('assets/poker_chips_banner.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black26,
                  Colors.black87
                ],
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 16.00, top: 180.00),
            child: Text(
              'Poker Tournament Timer',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'primaryBold',
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          pokerButton(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameSetupView(),
                ));
          }, "Create Game"),
          pokerButton(() {}, "Join Game"),
        ]),
        // Spacer(),
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            '© Sam Malcolm Media 2021',
            style: TextStyle(color: Colors.grey, fontSize: 10.0),
          )
        ])
      ])
    ], padding: false);
  }
}
