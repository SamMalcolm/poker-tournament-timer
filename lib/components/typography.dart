import 'package:flutter/material.dart';

Widget bodyText(String content, {size: 16.00}) {
  return Text(content,
      style: TextStyle(
          color: Colors.white, fontFamily: 'primaryLight', fontSize: size));
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

Widget heading3(String content) {
  return Text(content,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.00,
          fontFamily: 'primaryBold'));
}
