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
    // final file = File('${appDocDir.path}/My Ga.txt');
    // String text = await file.readAsString();
    // print(text);
  } catch (e) {
    print("Couldn't read file");
    return [];
  }
}

readFile(fileName) async {
  String output = "";
  try {
    print("\n\n READ FILE \n\n");
    print(fileName);
    print("\n\n FILE \n\n");
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocDir.path}/$fileName');
    print(file);
    print("\n\n TEXT \n\n");
    String text = await file.readAsString();
    print(text);
    return text;
  } catch (e) {
    print(e);
    print("Couldn't read file");
    return output;
  }
}
