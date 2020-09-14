import 'package:flutter/material.dart';

const textInputdecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0)),
  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
);

var boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.deepOrange[600], Colors.deepOrange[200]],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ),
    borderRadius: BorderRadius.circular(30.0));
