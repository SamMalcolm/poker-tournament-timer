import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_tournament_timer/components/typography.dart';
import 'components/mainViewTemplate.dart';
import 'components/buttons.dart';
import 'components/divider.dart';
import 'package:intl/intl.dart';
import 'controller/fileController.dart';

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
    if (new RegExp('\.DS_Store').hasMatch(configFiles[i].toString()) == false) {
      String filePath = configFiles[i].toString();
      print(filePath);
      List brokenFilePath = filePath.split("/");
      List brokenFileName =
          brokenFilePath[brokenFilePath.length - 1].split("--");
      print(brokenFileName);
      String fileName = decodeWhiteSpace(brokenFileName[0]);
      print(fileName);

      List brokenDate = brokenFileName[1].split('.');
      String dateWithT =
          brokenDate[0].substring(0, 8) + 'T' + brokenDate[0].substring(8);
      DateTime date = DateTime.parse(dateWithT);
      output.add(fileCard(fileName, date, () {
        Navigator.pop(context);
        updateGame(brokenFilePath[brokenFilePath.length - 1]);
      }));
    }
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
