import 'dart:io';
import 'package:path_provider/path_provider.dart';

void save(fileName, gameString, date) async {
  print(gameString);
  Directory appDocDir = await getApplicationDocumentsDirectory();
  final file = File('${appDocDir.path}/$fileName--$date.txt');
  await file.writeAsString(gameString);
  print('saved');
}

Future<List<dynamic>> readDir() async {
  try {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var files = Directory(appDocDir.path).listSync();
    print(files);
    return files;
  } catch (e) {
    print("Couldn't read file");
    return [];
  }
}

readFile(fileName) async {
  String output = "";
  try {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    print('${appDocDir.path}/$fileName');
    final file = File('${appDocDir.path}/$fileName');
    String text = await file.readAsString();
    return text;
  } catch (e) {
    print(e);
    print("Couldn't read file");
    return output;
  }
}
