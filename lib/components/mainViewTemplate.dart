import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget mainViewTemplate(children, {padding: true}) {
  return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
            Color.fromRGBO(35, 39, 88, 1),
            Color.fromRGBO(0, 0, 0, 1)
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: (padding)
                  ? const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0)
                  : const EdgeInsets.all(0.0),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children))));
}
