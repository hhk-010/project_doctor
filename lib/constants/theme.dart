import 'dart:ui';
import 'package:flutter/material.dart';

const textInputdecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.orangeAccent)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
  errorStyle: TextStyle(fontSize: 14, color: Colors.indigo),
  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
);

var boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    border: Border.all(
      color: Colors.deepOrange,
      width: 2,
    ));
