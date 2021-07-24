import 'package:flutter/material.dart';

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
                  ? const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0)
                  : const EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children),
              ))));
}
