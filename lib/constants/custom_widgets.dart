import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              getColor(context, LightPalette.background, DarkPalette.backgroundT),
              getColor(context, LightPalette.background, DarkPalette.backgroundB),
            ],
          ),
        ),
        child: child);
  }
}
