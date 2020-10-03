import 'package:flutter/material.dart';

class Result2 extends StatefulWidget {
  @override
  _Result2State createState() => _Result2State();
}

class _Result2State extends State<Result2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'The Result',
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
      ),
    );
  }
}
