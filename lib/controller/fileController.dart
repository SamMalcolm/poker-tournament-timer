import 'dart:io';
import 'package:path_provider/path_provider.dart';

String encodeWhiteSpace(str) {
  final newString = str.replaceAllMapped(RegExp('[\\s]+'), (match) {
    return "%20";
  });
  return newString;
}

String decodeWhiteSpace(str) {
  final newString = str.replaceAllMapped(RegExp('%20'), (match) {
    return " ";
  });
  return newString;
}

void save(fileName, gameString, date) async {
  print(gameString);
  Directory appDocDir = await getApplicationDocumentsDirectory();

  final file =
      File("${appDocDir.path}/${encodeWhiteSpace(fileName)}--$date.txt");
  print('${appDocDir.path}/${encodeWhiteSpace(fileName)}--$date.txt');
  await file.writeAsString(gameString);
  print('saved');
}

Future<List<dynamic>> readDir() async {
  try {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var files = appDocDir.listSync();
    print(files);
    return files;
  } catch (e) {
    print("Couldn't read directory");
    return [];
  }
}

// Future<String> readFile(fileName) async {
//   String output = "";
//   try {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     final file = File(appDocDir.path + "/" + fileName);
//     String text = await file.readAsString();
//     return text;
//   } catch (e) {
//     print(e);
//     print("Couldn't read file");
//     return output;
//   }
// }

Future<String> readFile(f) async {
  try {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    f = f.substring(0, (f.length - 1));
    final file = File(appDocDir.path + '/' + f);
    String text = await file.readAsString();
    print(text);
    return text;
  } catch (e) {
    print(e);
    return "Couldn't read file";
  }
}

void deleteFile(f) async {
  try {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    f = f.substring(0, (f.length - 1));
    final file = File(appDocDir.path + '/' + f);
    file.deleteSync();
  } catch (e) {
    print(e);
    print("couldnt delete file");
  }
}
