import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget pokerButton(onPressed, text,
    {colors: const <Color>[
      Color.fromRGBO(87, 90, 118, 1),
      Color.fromRGBO(45, 49, 82, 1),
    ]}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors)),
        child: MaterialButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ))),
  );
}
