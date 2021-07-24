import 'package:flutter/material.dart';

Widget pokerTextField(onChanged, {numbersOnly: false, controller: false}) {
  return Expanded(
    child: TextField(
      keyboardType: (numbersOnly) ? TextInputType.number : TextInputType.text,
      controller: (controller != false) ? controller : null,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget dropDownField(value, options, changed) {
  return Expanded(
    child: DropdownButton<String>(
      value: value,
      onChanged: changed,
      iconEnabledColor: Colors.white,
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      style: const TextStyle(color: Colors.black),
      selectedItemBuilder: (BuildContext context) {
        return options.map<Widget>((String value) {
          return Text(
            value,
            style: const TextStyle(color: Colors.white),
          );
        }).toList();
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}
