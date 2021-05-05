import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget> actions;
  final bool isAppbar;
  final Widget bottomNavigationBar;
  final bool extendbody;

  const BaseScaffold({Key key, this.child, this.title, this.actions, this.isAppbar, this.bottomNavigationBar, this.extendbody}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: extendbody,
        appBar: isAppbar
            ? PreferredSize(
                preferredSize: Size.fromHeight(getDeviceType(context, 40, 50, 60, 70)),
                child: AppBar(
                  title: Text(title, style: CStyle.appbarTitle),
                  centerTitle: true,
                  elevation: 0.0,
                  flexibleSpace: Container(
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            getColor(context, LightPalette.appbar1, DarkPalette.appbar1),
                            getColor(context, LightPalette.appbar2, DarkPalette.appbar1),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                  ),
                  actions: actions,
                ),
              )
            : null,
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  getColor(context, LightPalette.background, DarkPalette.background2),
                  getColor(context, LightPalette.background, DarkPalette.background1),
                ],
              ),
            ),
            child: child),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
