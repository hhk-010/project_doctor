import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: SpinKitFadingCircle(
          size: 75.0,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}


class DDDD extends StatefulWidget {
  @override
  _DDDDState createState() => _DDDDState();
}

class _DDDDState extends State<DDDD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
