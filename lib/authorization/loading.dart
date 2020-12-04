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
    return Container();
  }
}

class LoadingButton extends StatelessWidget {
  bool isloading;
  Widget child;
  Function onpressed;
  Color backgroundcolor;
  Color loadercolor;
  ShapeBorder shape;
  LoadingButton(
      {@required this.isloading,
      @required this.child,
      @required this.onpressed,
      this.backgroundcolor,
      this.loadercolor,
      this.shape});
  @override
  Widget build(BuildContext context) {
    return isloading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              backgroundColor: Colors.deepOrange,
              valueColor: AlwaysStoppedAnimation(this.loadercolor),
            ))
        : RaisedButton(
            child: child,
            onPressed: onpressed,
            color: backgroundcolor,
            shape: shape,
          );
  }
}

class FloatingLoadingButton extends StatelessWidget {
  bool isloading;
  Widget child;
  Function onPressed;
  Color backgroundcolor;
  Color loadercolor;
  ShapeBorder shape;
  FloatingLoadingButton(
      {@required this.isloading,
      @required this.child,
      @required this.onPressed,
      this.backgroundcolor,
      this.loadercolor,
      this.shape});
  @override
  Widget build(BuildContext context) {
    return isloading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              backgroundColor: Colors.deepOrange,
              valueColor: AlwaysStoppedAnimation(this.loadercolor),
            ))
        : FloatingActionButton(
            child: child,
            onPressed: onPressed,
            backgroundColor: backgroundcolor,
            shape: shape,
          );
  }
}

class LoadingButtonIcon extends StatelessWidget {
  bool isloading;
  Widget label;
  Function onpressed;
  Color backgroundcolor;
  Color loadercolor;
  ShapeBorder shape;
  ShapeBorder loadershape;
  Icon icon;
  LoadingButtonIcon(
      {@required this.isloading,
      @required this.label,
      @required this.onpressed,
      this.backgroundcolor,
      this.loadercolor,
      this.shape,
      //this.loadershape,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return isloading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              backgroundColor: Colors.deepOrange,
              valueColor: AlwaysStoppedAnimation(this.loadercolor),
            ))
        : RaisedButton.icon(
            label: label,
            onPressed: onpressed,
            color: backgroundcolor,
            shape: shape,
            icon: icon,
          );
  }
}
