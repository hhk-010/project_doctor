import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:easy_localization/easy_localization.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final bool isAppbar;
  final Widget bottomNavigationBar;
  final Widget action;

  const BaseScaffold({
    Key key,
    this.child,
    this.title,
    this.isAppbar,
    this.bottomNavigationBar,
    this.action,
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
                  title: Text(title, style: CustomStyle.getHeading(context)),
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
                  actions: [action],
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

PopupMenuButton<String> getAppActions(BuildContext context) {
  return PopupMenuButton<String>(
      onSelected: (action) {
        if (action == '0') {
          if (getLocale(context))
            context.setLocale(Locale('ar'));
          else
            context.setLocale(Locale('en'));
        }
        if (action == '1') getThemeManager(context).toggleDarkLightTheme();
      },
      itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: '0',
              child: ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  'popupMenu.language'.tr(),
                  style: CustomStyle.getSubtitle(context),
                ),
              ),
            ),
            PopupMenuItem(
              value: '1',
              child: ListTile(
                leading: Icon(Icons.color_lens),
                title: Text(
                  'popupMenu.theme'.tr(),
                  style: CustomStyle.getSubtitle(context),
                ),
              ),
            ),
          ]);
}
