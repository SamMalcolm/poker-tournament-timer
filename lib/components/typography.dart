import 'package:flutter/material.dart';

Widget bodyText(String content, {size: 16.00, color: Colors.white}) {
  return Text(content,
      style:
          TextStyle(color: color, fontFamily: 'primaryLight', fontSize: size));
}

Widget heading1(String content) {
  return Text(content,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 32.00,
          fontFamily: 'primaryBold'));
}

Widget heading2(String content) {
  return Text(content,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24.00,
          fontFamily: 'primaryBold'));
}

Widget heading3(String content, {fontSize: 18.00}) {
  return Text(content,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          fontFamily: 'primaryBold'));
}

String intToDollarValue(int number) {
  String output = number.toString();
  List brokenStr = output.split('');
  Iterable<dynamic> reversedList = brokenStr.reversed;
  brokenStr = reversedList.toList();
  List newNumber = [];
  if (brokenStr.length > 3) {
    for (int i = 0; i < brokenStr.length; i++) {
      if (i % 3 == 0 && i != 0) {
        newNumber.add(',');
      }
      newNumber.add(brokenStr[i]);
    }
  } else {
    newNumber = brokenStr;
  }
  reversedList = newNumber.reversed;
  brokenStr = reversedList.toList();
  output = '\$' + brokenStr.join('');
  return output;
}
