import 'package:flutter/material.dart';

const textInputdecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.deepOrange)),
  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
);

var boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.deepOrange[600], Colors.deepOrange[200]],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ),
    borderRadius: BorderRadius.circular(30.0));

class PopUpMenuConstants {
  static const String logOut = 'Log Out';
  static const String settings = 'Settings';

  static const List<String> choices = <String>[
    logOut,
    settings,
  ];
}
