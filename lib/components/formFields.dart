import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './typography.dart';

Widget pokerTextFieldChild(onChanged,
    {numbersOnly: false, controller: false, noSpecialChars: false}) {
  return TextField(
    inputFormatters: (noSpecialChars)
        ? [
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
          ]
        : [],
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
  );
}

Widget pokerTextField(onChanged,
    {numbersOnly: false,
    controller: false,
    expanded: true,
    noSpecialChars: false}) {
  return (expanded)
      ? Expanded(
          child: pokerTextFieldChild(onChanged,
              numbersOnly: numbersOnly,
              controller: controller,
              noSpecialChars: noSpecialChars))
      : pokerTextFieldChild(onChanged,
          numbersOnly: numbersOnly,
          controller: controller,
          noSpecialChars: noSpecialChars);
}

Widget dropDownField(value, options, changed) {
  return Expanded(
    child: DropdownButton<String>(
      value: value,
      isDense: true,
      hint: bodyText("Chip Colour"),
      onChanged: changed,
      iconEnabledColor: Colors.white,
      isExpanded: true,
      underline: Container(
        height: 1.0,
        color: Colors.white,
      ),
      style: const TextStyle(color: Colors.black),
      selectedItemBuilder: (BuildContext context) {
        return options.map<Widget>((String value) {
          return bodyText(value);
        }).toList();
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: bodyText(value, color: Colors.black),
        );
      }).toList(),
    ),
  );
}

Widget pokerCheckbox(label, changed, value) {
  return CheckboxListTile(
    // tileColor: Color.fromRGBO(255, 255, 255, 0.2),
    checkColor: Colors.white,
    title: bodyText(label, size: 12.0),
    value: value,
    onChanged: changed,
  );
}
