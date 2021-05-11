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


class LoadingButton extends StatelessWidget {
  final bool isloading;
  final Widget child;
  final Function onpressed;
  final Color backgroundcolor;
  final Color loadercolor;
  final ShapeBorder shape;
  LoadingButton({@required this.isloading, @required this.child, @required this.onpressed, this.backgroundcolor, this.loadercolor, this.shape});
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
        : TextButton(
            style: TextButton.styleFrom(
              backgroundColor: backgroundcolor,
              shape: shape,
            ),
            child: child,
            onPressed: onpressed,
          );
  }
}



class LoadingButtonIcon extends StatelessWidget {
  final bool isloading;
  final Widget label;
  final Function onpressed;
  final Color backgroundcolor;
  final Color loadercolor;
  final ShapeBorder shape;
  final ShapeBorder loadershape;
  final Icon icon;
  LoadingButtonIcon(
      {@required this.isloading,
      @required this.label,
      @required this.onpressed,
      this.backgroundcolor,
      this.loadercolor,
      this.shape,
      this.loadershape,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return isloading
        ? SizedBox(
            width: 20,
            height: 20,
            child: Container(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                backgroundColor: Colors.deepOrange,
                valueColor: AlwaysStoppedAnimation(this.loadercolor),
              ),
            ))
        : TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: backgroundcolor,
              shape: shape,
            ),
            label: label,
            onPressed: onpressed,
            icon: icon,
          );
  }
}
