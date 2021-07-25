import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_tournament_timer/components/typography.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'components/divider.dart';

class SavedConfigView extends StatefulWidget {
  SavedConfigView(
      {Key? key, required this.configFiles, required this.updateGameFromFile})
      : super(key: key);
  final configFiles;
  final updateGameFromFile;
  @override
  _SavedConfigViewState createState() => _SavedConfigViewState();
}

Widget fileCard(fileName, date, ontap) {
  return Card(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            onTap: ontap,
            title: heading3(fileName),
            subtitle: bodyText(date.toString()))),
  );
}

List<Widget> displayConfig(configFiles, updateGame, context) {
  List<Widget> output = [];

  for (int i = 0; i < configFiles.length; i++) {
    String filePath = configFiles[i].toString();
    List brokenFilePath = filePath.split('/');
    List brokenFileName = brokenFilePath[brokenFilePath.length - 1].split('--');
    String fileName = brokenFileName[0];
    List brokenDate = brokenFileName[1].split('.');
    DateTime date = DateTime.parse(brokenDate[0]);

    output.add(fileCard(fileName, date, () {
      Navigator.pop(context);
      updateGame(filePath);
    }));
  }

  return output;
}

class _SavedConfigViewState extends State<SavedConfigView> {
  @override
  Widget build(BuildContext context) {
    return mainViewTemplate([
      pokerSpacer(),
      heading1("Load Config"),
      ...pokerDivider(),
      ...displayConfig(widget.configFiles, widget.updateGameFromFile, context)
    ]);
  }
}
