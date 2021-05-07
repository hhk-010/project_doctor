import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:easy_localization/easy_localization.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget> actions;
  final bool isAppbar;
  final Widget bottomNavigationBar;

  const BaseScaffold({
    Key key,
    this.child,
    this.title,
    this.actions,
    this.isAppbar,
    this.bottomNavigationBar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: isAppbar
            ? PreferredSize(
                preferredSize: Size.fromHeight(getDeviceType(context, 40, 50, 60, 70)),
                child: AppBar(
                  title: Text(title, style: CStyle.getHeading(context)),
                  centerTitle: true,
                  elevation: 0.0,
                  flexibleSpace: Container(
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          getColor(context, LightPalette.gradientTop, DarkPalette.gradientTop),
                          getColor(context, LightPalette.gradientBottom, DarkPalette.gradientBottom),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.color_lens),
                      onPressed: () => getThemeManager(context).toggleDarkLightTheme(),
                    ),
                    IconButton(
                      icon: Icon(Icons.language),
                      onPressed: () async {
                        if (getLocale(context)) {
                          await context.setLocale(Locale('ar'));
                        } else {
                          await context.setLocale(Locale('en'));
                        }
                      },
                    ),
                  ],
                ),
              )
            : null,
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
                colors: [
                  getColor(context, Colors.white, DarkPalette.gradientBottom),
                  getColor(context, Colors.white, DarkPalette.gradientTop),
                ],
              ),
            ),
            child: child),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
